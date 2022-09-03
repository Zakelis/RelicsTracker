// main.cpp : Defines the entry point for the application.

#include <iostream>
#include <map>
#include <algorithm>
#include <cstdlib>
#include <string>

#include <Object.h>
#include <ComputationHandler.h>
#include <Windows.h>

int main() {
    
    bool finished = false;
    while (!finished)
    {
        if (GetAsyncKeyState(VK_ESCAPE) < 0) {
            finished = true;
        }
    }
    return 0;
}