#ifndef RISKS_H_INCLUDED
#define RISKS_H_INCLUDED
#include <vector>
#include "Location.h"
class Event
{
public:
    Event (Location * loc, double dang, double rad) :
        location(loc),
        danger(dang),
        radius(rad)
    {

    }
    Location * location;
    double danger;
    double radius;
};

class Risks
{
public:
    Risks()
    {

    }
    virtual ~Risks()
    {
        for (int i = 0; i < mevents.size(); i++)
        {
            delete mevents[i].location;
        }
    }
    void push_event(Location * loc, double danger, double radius)
    {
        mevents.push_back(Event(loc, danger, radius));
    }
    std::vector<Event> events()
    {
        return mevents;
    }
private:
    std::vector<Event> mevents;

};

#endif // RISKS_H_INCLUDED
