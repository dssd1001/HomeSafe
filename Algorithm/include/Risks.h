#ifndef RISKS_H_INCLUDED
#define RISKS_H_INCLUDED
#include <vector>
#include "Location.h"
class Location;

class Event
{
public:
    Event (double lat, double lon, double dang, double rad) :
        latitude(lat),
        longitude(lon),
        danger(dang),
        radius(rad)
    {

    }
    double latitude;
    double longitude;
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
    void push_event(double lat, double lon, double danger, double radius)
    {
        mevents.push_back(Event(lat, lon, danger, radius));
    }
    std::vector<Event> events() const
    {
        return mevents;
    }
private:
    std::vector<Event> mevents;

};

#endif // RISKS_H_INCLUDED
