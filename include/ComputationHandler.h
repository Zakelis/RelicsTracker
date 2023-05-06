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

class ComputationHandler {
public:
    explicit ComputationHandler() = default;

    void setWAThreshold(double WAThreshold);
    bool rebuildCache();

    static unsigned int _loadingScreenPercentage;

    std::map<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> _lithRelics;
    std::map<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> _mesoRelics;
    std::map<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> _neoRelics;
    std::map<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> _axiRelics;

private:
    void filterPrimesAndRelics(nlohmann::json& allItemsJson);
    void filterPrimesBelowGivenWAPrice(nlohmann::json& ducanatorJson);
    void getRelicsForEligiblePrimes();
    void associateRelicWithPrime(nlohmann::json& dropsourcesJson,
        const Prime& prime);
    void processRelic(std::map<std::string, std::map<std::string, double>>& relicMap,
        const std::string& adjustedRelicName, const Prime& prime);
    void dumpResults();
    void dumpRelicMap(std::map<std::string, std::map<std::string, double>>& relicMap,
        const std::string& message);

    RequestHandler _requestHandler;
    std::map<std::string, Prime> _allPrimes;
    std::map<std::string, Relic> _allRelics;

    double _WAThreshold{0};
};


#endif //COMPUTATIONHANDLER_H
