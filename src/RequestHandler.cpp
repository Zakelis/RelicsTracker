#include <iostream>
#include <map>
#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <string>

#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "httplib.h"
#include <nlohmann/json.hpp>
#include "ComputationHandler.h"
#include "RequestHandler.h"
#include <windows.h>

bool RequestHandler::performGetRequest()
{
    ComputationHandler computationHandler;

    std::string body;
    // HTTPS
    httplib::Client cli("https://api.warframe.market");

    httplib::Headers languageHeader{
            {"language", "en"}
    };

    auto res = cli.Get("/v1/items", languageHeader);
    std::cout << "Request status : " << res->status << std::endl;
    body = res->body;
    nlohmann::json jParser;

    nlohmann::json parsedJson = jParser.parse(body);
    nlohmann::json inField = parsedJson["payload"]["items"];

    std::cout << "Retrieved items : " << inField.size() << std::endl;

    // Filter prime and relics.

    for (auto& element : inField) {
        std::string itemName = element["item_name"];
        std::string itemId = element["id"];
        std::string itemUrlName = element["url_name"];
        if (itemName.find(" Prime") != std::string::npos && itemName.find(" Set") == std::string::npos)
        {
            Prime prime(itemId, itemName, itemUrlName);
            computationHandler._allPrimes.emplace(itemId, prime);
        }
        else if (itemName.find(" Relic") != std::string::npos)
        {
            Relic relic(itemId, itemName, itemUrlName);
            computationHandler._allRelics.emplace(itemId, relic);
        }
    }

    std::cout << computationHandler._allPrimes.size() << " prime objects have been identified." << std::endl;
    std::cout << computationHandler._allRelics.size() << " relics have been identified." << std::endl;

    // Retrieve ducanator data with a GET request

    res = cli.Get("/v1/tools/ducats", languageHeader);
    std::cout << "Request status : " << res->status << std::endl;
    body = res->body;

    parsedJson = jParser.parse(body);
    inField = parsedJson["payload"]["previous_day"];

    double platLimit = 40.0;

    // Compute WAPP

    for (auto& element : inField) {
        std::string itemId = element["item"];
        auto primeObject = computationHandler._allPrimes.find(itemId);
        if (primeObject != computationHandler._allPrimes.end())
        {
            double waPlatPrice = element["wa_price"];
            unsigned int ducats = element["ducats"];
            if (waPlatPrice >= platLimit) {
                primeObject->second._ducats = ducats;
                primeObject->second._weightedAvgPlatPrice = waPlatPrice;
            }
            else
                computationHandler._allPrimes.erase(primeObject);
        }
    }

    std::cout << computationHandler._allPrimes.size() << " prime objects are left considered after filtering parts below " << platLimit << " plats." << std::endl;

    for (auto& primeObjectData : computationHandler._allPrimes)
    {
        Sleep(350);
        std::string url = "/v1/items/" + primeObjectData.second._objectUrlName + "/dropsources";
        res = cli.Get(url.c_str(), languageHeader);
        body = res->body;
        try {
            parsedJson = jParser.parse(body);
        }
        catch (const std::exception&) {
            std::cout << "JSON exception" << std::endl;
            continue;
        }

        auto relics = parsedJson["payload"]["dropsources"];

        for (auto& relicDrop : relics) {
            std::string relicId = relicDrop["relic"];
            std::string adjustedRelicName;
            for (auto& relic : computationHandler._allRelics)
            {
                if (relicId == relic.first)
                {
                    adjustedRelicName = relic.second._objectName;
                    break;
                }
            }
            auto orderedRelicInfo = computationHandler._orderedRelics.find(adjustedRelicName);
            if (orderedRelicInfo == computationHandler._orderedRelics.end())
            {
                std::pair<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> relicInfo;
                std::map<std::string /*itemName*/, double /*WAPrice*/> associatedItems;
                associatedItems.emplace(primeObjectData.second._objectName, primeObjectData.second._weightedAvgPlatPrice);
                relicInfo.first = adjustedRelicName;
                relicInfo.second = associatedItems;
                computationHandler._orderedRelics.emplace(relicInfo);
            }
            else
                orderedRelicInfo->second.emplace(primeObjectData.second._objectName, primeObjectData.second._weightedAvgPlatPrice);
        }
    }

    std::cout << "There are " << computationHandler._orderedRelics.size() << " relics left to keep : " << std::endl << std::endl;

    char refFirstLetter = computationHandler._orderedRelics.begin()->first.at(0);
    std::cout << "Axi Relics : " << std::endl << std::endl;
    int i = 0;
    for (auto& relicInfo : computationHandler._orderedRelics) {
        if (relicInfo.first.at(0) != refFirstLetter)
        {
            if (i == 0)
            {
                std::cout << std::endl << "Lith Relics : " << std::endl << std::endl;
            }
            else if (i == 1)
            {
                std::cout << std::endl << "Meso Relics : " << std::endl << std::endl;
            }
            else
            {
                std::cout << std::endl << "Neo Relics: " << std::endl << std::endl;
            }
            refFirstLetter = relicInfo.first.at(0);
            i++;
        }
        std::cout << relicInfo.first;
        for (auto relicObjectsInfo : relicInfo.second)
        {
            std::cout << " - " << relicObjectsInfo.first << " (" << relicObjectsInfo.second << ")";
        }
        std::cout << std::endl;
    }
	return true;
}