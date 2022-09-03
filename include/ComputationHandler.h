#pragma once

#ifndef COMPUTATIONHANDLER_H
#define COMPUTATIONHANDLER_H


#include "Object.h"
#include "RequestHandler.h"
#include <map>
#include <string>
#include <iostream>
#include <iomanip>

struct DescendingWAPlatPriceSorter
{
    inline bool operator() (const Object& lhs, const Object& rhs) const
    {
        return (lhs._weightedAvgPlatPrice > rhs._weightedAvgPlatPrice);
    }
};

class ComputationHandler {
public:
    explicit ComputationHandler() = default;

    std::map<std::string, Object> _allObjects;
    std::map<std::string /*relicName*/, std::map<std::string /*itemName*/, double /*WAPrice*/>> _orderedRelics; // TODO identify vaulted relics ?
};


#endif //COMPUTATIONHANDLER_H
