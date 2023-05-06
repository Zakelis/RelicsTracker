#include "ComputationHandler.h"

unsigned int ComputationHandler::_loadingScreenPercentage = 0;

void ComputationHandler::setWAThreshold(double WAThreshold)
{
    _WAThreshold = WAThreshold;
}

bool ComputationHandler::rebuildCache()
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

    filterPrimesBelowGivenWAPrice(ducanatorJson);

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

void ComputationHandler::filterPrimesBelowGivenWAPrice(nlohmann::json& ducanatorJson)
{
    nlohmann::json primesData = ducanatorJson["payload"]["previous_day"];

    // Compute WAP for each item
    std::cout << "Filtering primes below " << _WAThreshold << " plats" << std::endl;

    for (auto& primeData : primesData) {
        std::string itemId = primeData["item"];
        auto primeObject = _allPrimes.find(itemId);
        if (primeObject != _allPrimes.end())
        {
            double waPlatPrice = primeData["wa_price"];
            unsigned int ducats = primeData["ducats"];
            if (waPlatPrice >= _WAThreshold) {
                primeObject->second._ducats = ducats;
                primeObject->second._weightedAvgPlatPrice = waPlatPrice;
            }
            else
                _allPrimes.erase(primeObject);
        }
    }

    std::cout << _allPrimes.size() << " primes were worth " << _WAThreshold << " plats in the last 48 hours." << std::endl;
}

void ComputationHandler::getRelicsForEligiblePrimes()
{
    std::cout << "Getting the list of valuable relics :" << std::endl;
    unsigned int i = 0;
    for (auto& primeData : _allPrimes)
    {
        _loadingScreenPercentage = i * 100 / static_cast<unsigned int>(_allPrimes.size());
        // Percentage
        std::cout << "\33\r" << _loadingScreenPercentage << " % complete." << std::flush;

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
    _loadingScreenPercentage = 100;
    std::cout << std::endl;
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
        switch (adjustedRelicName.front())
        {
        case 'L':
            processRelic(_lithRelics, adjustedRelicName, prime);
            break;
        case 'M':
            processRelic(_mesoRelics, adjustedRelicName, prime);
            break;
        case 'N':
            processRelic(_neoRelics, adjustedRelicName, prime);
            break;
        case 'A':
            processRelic(_axiRelics, adjustedRelicName, prime);
            break;
        default:
            break;
        }
    }
}

void ComputationHandler::processRelic(std::map<std::string, std::map<std::string, double>>& relicMap,
    const std::string& adjustedRelicName, const Prime& prime)
{
    auto orderedRelicInfo = relicMap.find(adjustedRelicName);
    if (orderedRelicInfo == relicMap.end())
    {
        std::map<std::string, double> associatedItems;
        associatedItems.emplace(prime._objectName, prime._weightedAvgPlatPrice);
        std::pair<std::string, std::map<std::string, double>> relicInfo(adjustedRelicName, associatedItems);
        relicMap.emplace(relicInfo);
    }
    else
        orderedRelicInfo->second.emplace(prime._objectName, prime._weightedAvgPlatPrice);
}

void ComputationHandler::dumpResults()
{
    dumpRelicMap(_lithRelics, "Lith Relics :");
    dumpRelicMap(_mesoRelics, "Meso Relics :");
    dumpRelicMap(_neoRelics, "Neo Relics :");
    dumpRelicMap(_axiRelics, "Axi Relics :");
}

void ComputationHandler::dumpRelicMap(std::map<std::string, std::map<std::string, double>>& relicMap,
    const std::string& message)
{
    std::cout << message << std::endl << std::endl;
    for (auto& relicInfo : relicMap) {
        std::cout << relicInfo.first;
        for (auto relicObjectsInfo : relicInfo.second)
        {
            std::cout << " - " << relicObjectsInfo.first << " (" << relicObjectsInfo.second << ")";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}