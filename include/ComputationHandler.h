#pragma once

#ifndef COMPUTATIONHANDLER_H
#define COMPUTATIONHANDLER_H

#include "Prime.h"
#include "Relic.h"
#include "RequestHandler.h"
#include <iomanip>
#include <iostream>
#include <map>
#include <string>

enum WASortingStrategy
{
    ASCENDING,
    DESCENDING
};

enum OutputStrategy
{
    ALL,
    ITEMS_ONLY,
    RELICS_ONLY
};

struct DescendingWAPriceSorter
{
    inline bool operator() (const Prime& lhs, const Prime& rhs) const
    {
        return (lhs._weightedAvgPlatPrice > rhs._weightedAvgPlatPrice);
    }
};

class ComputationHandler {
public:
    explicit ComputationHandler() = default;

    bool rebuildCache(double WAThreshold);

private:
    void filterPrimesAndRelics(nlohmann::json& allItemsJson);
    void filterPrimesBelowGivenWAPrice(nlohmann::json& ducanatorJson,
                                       const double WAThreshold);
    void getRelicsForEligiblePrimes();
    void associateRelicWithPrime(nlohmann::json& dropsourcesJson,
                                const Prime& prime);
    void dumpResults();

    RequestHandler _requestHandler;
    std::map<std::string, Prime> _allPrimes;
    std::map<std::string, Relic> _allRelics;
    std::map<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> _orderedRelics; // TODO identify vaulted relics ?
};


#endif //COMPUTATIONHANDLER_H
