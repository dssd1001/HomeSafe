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
    virtual ~City()
    {
        for (int i = 0; i < (int) intersections.size(); i++)
        {
            delete intersections[i];
        }
    }

    std::vector<std::pair<double, double> > Astar(Location* start, Location* goal)
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
        fScore[start] = start->distance(*goal) * start->distance_weight;
        while (!openSet.empty())
        {

            Location* current = *(std::min_element(openSet.begin(), openSet.end(), [fScore] (Location* a, Location* b) mutable -> bool
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
                                        ));
            if (current == goal)
                return reconstruct_path(cameFrom, current);

            openSet.erase(current);
            closedSet.insert(current);
            for (Location* neighbor : current->get_connections())
            {
                if (closedSet.find(neighbor) != closedSet.end())
                    continue; // Ignore the neighbor that is already evaluated
                // The distance from start to a neighbor
                double tentative_gScore = gScore[current] + weight(*current, *neighbor, current_risks);
                if (openSet.find(neighbor) == openSet.end())
                    openSet.insert(neighbor);
                else if (tentative_gScore >= gScore[neighbor])
                    continue; // We have not found a better path D:

                cameFrom[neighbor] = current;
                gScore[neighbor] = tentative_gScore;
                fScore[neighbor] = gScore[neighbor] + neighbor->distance(*goal) * neighbor->distance_weight;
            }
        }
    }

    void push_street(std::vector< std::pair<double, double> > inters)
    {
        Location* prev = nullptr;
        for (int i = 0; i < static_cast<int>(inters.size()); i++) {
            bool is_in_intersection = false;
            unsigned int j;
            for (j = 0; j < intersections.size(); j++)
            {
                if (inters[i].first == intersections[j]->get_latitude() && inters[i].second == intersections[j]->get_longitude())
                {
                    is_in_intersection = true;
                    break;
                }
            }
            if (!is_in_intersection)
            {
                Location *l = new Location(inters[i].first, inters[i].second);
                intersections.push_back(l);
                if(i > 0)
                {
                    l->add_connection(prev);
                    prev->add_connection(l);
                }
                prev = l;
            }
            else
            {
                if (i > 0)
                {
                    intersections[j]->add_connection(prev);
                    prev->add_connection(intersections[j]);
                }
                prev = intersections[j];
            }
        }
    }

    std::vector<Location*> get_intersections() const
    {
        return intersections;
    }
    void push_event(double latitude, double longitude, double danger, double radius)
    {
        Location* l = new Location(latitude, longitude);
        current_risks.push_event(l, danger, radius);
    }

private:
    std::vector<Location*> intersections;
    Risks current_risks;
    std::vector<std::pair<double, double> > reconstruct_path(std::map<Location*, Location*>& cameFrom, Location* current)
    {
        std::vector<Location*> total_path(1, current);
        while (cameFrom.count(current))
        {
            current = cameFrom[current];
            total_path.push_back(current);
        }
        std::reverse(total_path.begin(), total_path.end());
        std::vector< std::pair<double, double> > ret(total_path.size());
        for (unsigned int i = 0; i < total_path.size(); i++)
        {
            ret[i] = std::make_pair(total_path[i]->get_latitude(), total_path[i]->get_longitude());
        }
        return ret;
    }
    double weight(const Location& self, const Location& other, const Risks& risks)
    {
        Location midpoint((self.get_latitude() + other.get_latitude()) / 2, (self.get_longitude() + other.get_longitude()) / 2);
        double ret_value = 0;
        for (auto event : risks.events())
        {
            double d = midpoint.distance(*(event.location));
            double r = event.radius;
            double danger = event.danger;
            ret_value += danger * (r / d) * (r / d);
        }
        return ret_value + self.distance(other) * self.distance_weight;
    }
};

#endif // MAIN_H_INCLUDED
