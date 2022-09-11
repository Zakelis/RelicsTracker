#pragma once

#ifndef ENUMS_H
#define ENUMS_H

enum class WindowScreenType
{
    MAIN_SCREEN,
    LOADING_SCREEN,
    RESULTS_SCREEN,
    HELP_SCREEN
};

enum class ActiveRelicCategory
{
    LITH,
    MESO,
    NEO,
    AXI,
    NONE
};

enum class WASortingStrategy
{
    ASCENDING,
    DESCENDING
};

enum class OutputStrategy
{
    ALL,
    ITEMS_ONLY,
    RELICS_ONLY
};

#endif //ENUMS_H