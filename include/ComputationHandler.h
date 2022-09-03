#pragma once

#ifndef COMPUTATIONHANDLER_H
#define COMPUTATIONHANDLER_H

#include "Prime.h"
#include "Relic.h"
#include "RequestHandler.h"
#include <map>
#include <string>
#include <iostream>
#include <iomanip>

struct DescendingWAPlatPriceSorter
{
    inline bool operator() (const Prime& lhs, const Prime& rhs) const
    {
        return (lhs._weightedAvgPlatPrice > rhs._weightedAvgPlatPrice);
    }
};

class ComputationHandler {
public:
    explicit ComputationHandler() = default;

    std::map<std::string, Prime> _allPrimes;
    std::map<std::string, Relic> _allRelics;
    std::map<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> _orderedRelics; // TODO identify vaulted relics ?
};


#endif //COMPUTATIONHANDLER_H
