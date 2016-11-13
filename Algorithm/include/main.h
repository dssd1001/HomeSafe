#ifndef MAIN_H_INCLUDED
#define MAIN_H_INCLUDED

#include <vector>
#include <utility>
#include "Location.h"
#include "Risks.h"
#include <set>
#include <map>

class City
{
public:
    City() = default;

    std::vector<Location*> Astar(Location* start, Location* goal)
    {
        std::set<Location*> closedSet;
        std::set<Location*> openSet;
        openSet.insert(start);
        std::map<Location*, Location*> cameFrom;

        // For each node, the cost of getting from the start node to that node.
        std::map<Location*, double> gScore;
        // The cost of going from start to start is zero
        gScore[start] = 0;

        // For each node, the total cost of getting from the start node to the goal
        // by passing by that node. That value is partly known, partly heuristic
        std::map<Location*, double> fScore;
        fScore[start] = start->distance(goal);
        while (!openSet.empty())
        {
            Location* current = std::min(openSet.begin(), openSet.end(), [fScore](Location* a, Location* b) -> bool
                                         { if (fScore.count(a))
                                            {
                                                if (fScore.count(b))
                                                {
                                                    return fScore[a] < fScore[b];
                                                }
                                                else {
                                                    return true;
                                                }
                                            }
                                            else { return false; }
                                         }
                                        )
            if (current == goal)
                return reconstruct_path(cameFrom, current);
            for (Location* neighbor : current->connections)
            {
                if (closedSet.find(neighbor) != closedSet.end())
                    continue; // Ignore the neighbor that is already evaluated
                // The distance from start to a neighbor
                double tentative_gScore = gScore[current] + current.risk(neighbor, current_risks);
                if (openSet.find(neighbor) == openSet.end())
                {
                    openSet.insert(neighbor);
                }
                else if (tentative_gScore >= gScore[neighbor])
                {
                    continue;
                }
            }

        }
    }

private:
    std::vector<Location*> intersections;
    Risks current_risks;
};

#endif // MAIN_H_INCLUDED
