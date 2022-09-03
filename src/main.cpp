// main.cpp : Defines the entry point for the application.

#include <iostream>
#include <map>
#include <algorithm>
#include <cstdlib>
#include <string>

#include <ComputationHandler.h>
#include <Windows.h>

int main() {
    
    bool terminate = false;
    bool queryDone = false;

    RequestHandler requestHandler;

    while (!terminate)
    {
        if (GetAsyncKeyState(VK_ESCAPE) < 0) {
            terminate = true;
        }
        if (!queryDone)
        {
            if (requestHandler.performGetRequest())
            {
                queryDone = true;
            }
        }
    }
    return 0;
}