#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <map>
#include <string>
#include "RequestHandler.h"

void RequestHandler::performGetRequest(nlohmann::json& parsedJson,
    const std::string& uri)
{
    auto response = _client.Get(uri, _languageHeader);
    if (response->status != 200)
    {
        std::cout << "Unexpected status " << response->status << " was thrown" << std::endl;
        return;
    }

    std::string body = response->body;
    parsedJson = _jsonParser.parse(body);
}

void RequestHandler::queryEveryItemFromWFM(nlohmann::json& parsedJson)
{
    
    performGetRequest(parsedJson, "/v1/items");
}

void RequestHandler::queryDucanatorValues(nlohmann::json& parsedJson)
{
    performGetRequest(parsedJson, "/v1/tools/ducats");
}

void RequestHandler::queryPrimeDropsources(nlohmann::json& parsedJson,
                                           std::string& primeUrlName)
{
    std::string uri = "/v1/items/" + primeUrlName + "/dropsources";
    performGetRequest(parsedJson, uri);
}