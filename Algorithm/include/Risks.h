#ifndef RISKS_H_INCLUDED
#define RISKS_H_INCLUDED
#include <vector>
#include "Location.h"
class Location;

class Event
{
public:
    Event (Location * loc, double dang, double rad) :
        location(loc),
        danger(dang),
        radius(rad)
    {

    }
    virtual ~Event()
    {
        delete location;
        location = nullptr;
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
    }
    void push_event(Location * loc, double danger, double radius)
    {
        mevents.push_back(Event(loc, danger, radius));
    }
    std::vector<Event> events() const
    {
        return mevents;
    }
private:
    std::vector<Event> mevents;

};

#endif // RISKS_H_INCLUDED
