#pragma once

#ifndef REQUESTHANDLER_H
#define REQUESTHANDLER_H

class RequestHandler {
public:
    explicit RequestHandler() = default;

    bool performGetRequest();
};


#endif //REQUESTHANDLER_H
