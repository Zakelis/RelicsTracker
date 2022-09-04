#pragma once

#ifndef REQUESTHANDLER_H
#define REQUESTHANDLER_H

#define CPPHTTPLIB_OPENSSL_SUPPORT

#include "httplib.h"
#include "Prime.h"
#include "Relic.h"
#include <nlohmann/json.hpp>
#include <windows.h>

class RequestHandler {
public:
    explicit RequestHandler() = default;

    void queryEveryItemFromWFM(nlohmann::json& parsedJson);
    void queryDucanatorValues(nlohmann::json& parsedJson);
    void queryPrimeDropsources(nlohmann::json& parsedJson,
                                std::string& primeUrlName);
        
private:
    void performGetRequest(nlohmann::json& parsedJson,
                                     const std::string& uri);

    httplib::Client _client{ "https://api.warframe.market" };
    httplib::Headers _languageHeader{{"language", "en"}};
    nlohmann::json _jsonParser;
};


#endif //REQUESTHANDLER_H
