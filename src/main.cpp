// main.cpp : Defines the entry point for the application.
#include "ComputationHandler.h"
#include <windows.h>

void displayHeader()
{
    std::cout << "*******************************" << std::endl;
    std::cout << "** RelicsTracker by Zakelis  **" << std::endl;
    std::cout << "*******************************" << std::endl << std::endl;
    std::cout << "A practical tool that indicates all relics worthy to refine." << std::endl;
    std::cout << "Using non-static last 48 hours trade values ('Weighted Averages') from warframe.market !" << std::endl;
    std::cout << "Enter a minimum plat value and all drop locations for all eligible items will be shown." << std::endl << std::endl;
    std::cout << "Warning : Setting this entry at a low value (<= 35) can take more than a minute." << std::endl;
    std::cout << "This is because WFM's API only allows 3 requests per second." << std::endl << std::endl;
}

double WAThresholdPrompt()
{
    double newWAP = -1;
    std::cout << "Enter minimum plat price : ";
    std::cin >> newWAP;
    return newWAP;
}

int main()
{
    bool displayedHeader = false;
    bool terminate = false;
    bool updatedCache = false; // TODO : prompt for dynamic value, write cached results into a file.
    double WAThreshold = -1;

    ComputationHandler cacheBuilder;

    while (!terminate)
    {
        if (!displayedHeader)
        {
            displayHeader();
            displayedHeader = true;
        }

        if (GetAsyncKeyState(VK_ESCAPE) < 0) {
            terminate = true;
        }

        if (WAThreshold < 0)
        {
            double newWAP = WAThresholdPrompt();
            if (newWAP > 0)
            {
                WAThreshold = newWAP;
            }
        }

        if (!updatedCache && WAThreshold > 0)
        {
            if (cacheBuilder.rebuildCache(WAThreshold))
            {
                updatedCache = true;
            }
        }
    }
    return 0;
}