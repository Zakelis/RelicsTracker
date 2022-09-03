#pragma once

#ifndef PRIME_H
#define PRIME_H

#include <vector>
#include <string>
#include <utility>

class Prime
{
public:
    explicit Prime(std::string objectId, std::string objectName, std::string objectUrlName) :
        _objectId(std::move(objectId)),
        _objectName(std::move(objectName)),
        _objectUrlName(std::move(objectUrlName)) {};
    Prime() = delete;

    double _weightedAvgPlatPrice{ 0 };
    unsigned int _ducats{ 0 };
    std::vector<std::string> _relicsName{};
    std::string _objectId;
    std::string _objectName;
    std::string _objectUrlName;
};


#endif //PRIME_H