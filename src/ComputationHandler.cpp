#include "ComputationHandler.h"

bool ComputationHandler::rebuildCache(double WAThreshold)
{
    // All items
    nlohmann::json allItemsJson;
    _requestHandler.queryEveryItemFromWFM(allItemsJson);

    if (allItemsJson.is_null())
    {
        return true;
    }

    filterPrimesAndRelics(allItemsJson);

    std::cout << _allPrimes.size() << " primes have been identified." << std::endl;
    std::cout << _allRelics.size() << " relics have been identified." << std::endl;

    // Ducanator
    nlohmann::json ducanatorJson;
    _requestHandler.queryDucanatorValues(ducanatorJson);

    if (ducanatorJson.is_null())
    {
        return true;
    }

    filterPrimesBelowGivenWAPrice(ducanatorJson, WAThreshold);

    // Primes dropsources
    getRelicsForEligiblePrimes();

    dumpResults();

    return true;
}

// Extract prime and relics from all items.
void ComputationHandler::filterPrimesAndRelics(nlohmann::json& allItemsJson)
{
    nlohmann::json items = allItemsJson["payload"]["items"];

    for (auto& item : items) {
        std::string itemName = item["item_name"];
        if (itemName.find(" Prime") != std::string::npos && itemName.find(" Set") == std::string::npos)
        {
            std::string primeId = item["id"];
            std::string primeUrlName = item["url_name"];
            _allPrimes.emplace(primeId, Prime(primeId, itemName, primeUrlName));
        }
        else if (itemName.find(" Relic") != std::string::npos)
        {
            std::string relicId = item["id"];
            std::string relicUrlName = item["url_name"];
            _allRelics.emplace(relicId, Relic(relicId, itemName, relicUrlName));
        }
    }
}

void ComputationHandler::filterPrimesBelowGivenWAPrice(nlohmann::json& ducanatorJson,
                                                       double WAThreshold)
{
    nlohmann::json primesData = ducanatorJson["payload"]["previous_day"];

    // Compute WAP for each item
    std::cout << "Filtering primes below " << WAThreshold << " plats" << std::endl;

    for (auto& primeData : primesData) {
        std::string itemId = primeData["item"];
        auto primeObject = _allPrimes.find(itemId);
        if (primeObject != _allPrimes.end())
        {
            double waPlatPrice = primeData["wa_price"];
            unsigned int ducats = primeData["ducats"];
            if (waPlatPrice >= WAThreshold) {
                primeObject->second._ducats = ducats;
                primeObject->second._weightedAvgPlatPrice = waPlatPrice;
            }
            else
                _allPrimes.erase(primeObject);
        }
    }

    std::cout << _allPrimes.size() << " primes were worth " << WAThreshold << " plats in the last 48 hours." << std::endl;
}

void ComputationHandler::getRelicsForEligiblePrimes()
{
    std::cout << "Getting the list of valuable relics :" << std::endl;
    int i = 0;
    int perc = 0;
    for (auto& primeData : _allPrimes)
    {
        perc = i * 100 / _allPrimes.size();
        // Percentage
        std::cout << "\33\r" << perc << " % complete." << std::flush;

        nlohmann::json dropsourcesJson;
        _requestHandler.queryPrimeDropsources(dropsourcesJson, primeData.second._objectUrlName);

        if (dropsourcesJson.is_null())
        {
            continue;
        }

        associateRelicWithPrime(dropsourcesJson, primeData.second);
        Sleep(350); // 3 requests per second max
        ++i;
    }
    std::cout << std::endl;
    std::cout << "As per your criterias, there are " << _orderedRelics.size() << " relics worth refining : " << std::endl << std::endl;
}

void ComputationHandler::associateRelicWithPrime(nlohmann::json& dropsourcesJson,
                                                 const Prime& prime)
{
    auto relics = dropsourcesJson["payload"]["dropsources"];

    for (auto& relicDrop : relics) {
        std::string relicId = relicDrop["relic"];
        std::string adjustedRelicName;
        for (auto& relic : _allRelics)
        {
            if (relicId == relic.first)
            {
                adjustedRelicName = relic.second._objectName;
                break;
            }
        }
        auto orderedRelicInfo = _orderedRelics.find(adjustedRelicName);
        if (orderedRelicInfo == _orderedRelics.end())
        {
            std::pair<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> relicInfo;
            std::map<std::string /*itemName*/, double /*WAPrice*/> associatedItems;
            associatedItems.emplace(prime._objectName, prime._weightedAvgPlatPrice);
            relicInfo.first = adjustedRelicName;
            relicInfo.second = associatedItems;
            _orderedRelics.emplace(relicInfo);
        }
        else
            orderedRelicInfo->second.emplace(prime._objectName, prime._weightedAvgPlatPrice);
    }
}

void ComputationHandler::dumpResults()
{
    char refFirstLetter = _orderedRelics.begin()->first.at(0);
    std::cout << "Axi Relics : " << std::endl << std::endl;
    int i = 0;
    for (auto& relicInfo : _orderedRelics) {
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
}