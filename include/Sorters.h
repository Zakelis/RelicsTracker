#pragma once

#ifndef SORTERS_H
#define SORTERS_H

struct DescendingWAPriceSorter
{
    inline bool operator() (const Prime& lhs, const Prime& rhs) const
    {
        return (lhs._weightedAvgPlatPrice > rhs._weightedAvgPlatPrice);
    }
};

#endif //SORTERS_H