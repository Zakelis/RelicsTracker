#include <iostream>
#include <map>
#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <string>

#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "httplib.h"
#include <nlohmann/json.hpp>
#include <Object.h>
#include "ComputationHandler.h"
#include "RequestHandler.h"
#include <windows.h>

bool RequestHandler::performGetRequest()
{
    ComputationHandler computationHandler;

    std::string body;
    // HTTPS
    httplib::Client cli("https://api.warframe.market");

    httplib::Headers h{
            {"platform", "pc"},
            {"language", "en"}
    };
    auto res = cli.Get("/v1/items", h);
    std::cout << "Request status : " << res->status << std::endl;
    body = res->body;
    nlohmann::json jParser;

    nlohmann::json parsedJson = jParser.parse(body);
    nlohmann::json inField = parsedJson["payload"]["items"];

    std::cout << "Retrieved items : " << inField.size() << std::endl;

    // Filter prime from non-prime

    for (auto& element : inField) {
        std::string itemName = element["item_name"];
        std::string itemId = element["id"];
        std::string itemUrlName = element["url_name"];
        if (itemName.find(" Prime") != std::string::npos && itemName.find(" Set") == std::string::npos)
        {
            Object primeObject(itemId, itemName, itemUrlName);
            computationHandler._allObjects.emplace(itemId, primeObject);
        }
    }

    std::cout << computationHandler._allObjects.size() << " prime objects have been identified." << std::endl;

    // Retrieve ducanator data with a GET request

    res = cli.Get("/v1/tools/ducats", h);
    std::cout << "Request status : " << res->status << std::endl;
    body = res->body;

    parsedJson = jParser.parse(body);
    inField = parsedJson["payload"]["previous_day"];

    double platLimit = 40.0;

    // Compute WAPP

    for (auto& element : inField) {
        std::string itemId = element["item"];
        auto primeObject = computationHandler._allObjects.find(itemId);
        if (primeObject != computationHandler._allObjects.end())
        {
            double waPlatPrice = element["wa_price"];
            unsigned int ducats = element["ducats"];
            if (waPlatPrice >= platLimit) {
                primeObject->second._ducats = ducats;
                primeObject->second._weightedAvgPlatPrice = waPlatPrice;
            }
            else
                computationHandler._allObjects.erase(primeObject);
        }
    }

    std::cout << computationHandler._allObjects.size() << " prime objects are left considered after filtering parts below " << platLimit << " plats." << std::endl;

    for (auto& primeObjectData : computationHandler._allObjects)
    {
        Sleep(500);
        std::cout << "Current item URL Name : " << primeObjectData.second._objectUrlName << std::endl;
        std::string url = "/v1/items/" + primeObjectData.second._objectUrlName;
        res = cli.Get(url.c_str(), h);
        body = res->body;
        try {
            parsedJson = jParser.parse(body);
        }
        catch (const std::exception& ex) {
            (void)ex;
            std::cout << "JSON exception" << std::endl;
            continue;
        }
        bool found = false;
        int i = 0;
        while (!found)
        {
            std::string name = parsedJson["payload"]["item"]["items_in_set"][i]["en"]["item_name"];
            if (name == primeObjectData.second._objectName)
                found = true;
            else
                i++;
        }
        inField = parsedJson["payload"]["item"]["items_in_set"][i];

        auto relics = inField["en"]["drop"];
        if (relics.empty())
            continue;
        for (auto& relic : relics) {
            std::string relicName = relic["name"];
            std::string adjustedRelicName;
            std::string::size_type pos = relicName.find('(');
            if (pos != std::string::npos)
            {
                adjustedRelicName = relicName.substr(0, pos - 1);
            }
            else
                adjustedRelicName = relicName;
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
    if (computationHandler._orderedRelics.empty())
    {
        return true; // DEBUGs
    }

    char refFirstLetter = computationHandler._orderedRelics.begin()->first.at(0);
    std::cout << "Reliques Axi : " << std::endl << std::endl;
    int i = 0;
    for (auto& relicInfo : computationHandler._orderedRelics) {
        if (relicInfo.first.at(0) != refFirstLetter)
        {
            if (i == 0)
            {
                std::cout << std::endl << "Reliques Lith : " << std::endl << std::endl;
            }
            else if (i == 1)
            {
                std::cout << std::endl << "Reliques Meso : " << std::endl << std::endl;
            }
            else
            {
                std::cout << std::endl << "Reliques Neo : " << std::endl << std::endl;
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