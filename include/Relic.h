#pragma once

#ifndef RELIC_H
#define RELIC_H

#include <vector>
#include <string>
#include <utility>

class Relic
{
public:
    explicit Relic(std::string objectId, std::string objectName, std::string objectUrlName) :
        _objectId(std::move(objectId)),
        _objectName(std::move(objectName)),
        _objectUrlName(std::move(objectUrlName)) {};
    Relic() = delete;

    std::string _objectId;
    std::string _objectName;
    std::string _objectUrlName;
    bool        _isVaulted;
};


#endif //RELIC_H