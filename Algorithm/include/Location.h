#ifndef LOCATION_H
#define LOCATION_H
#include <vector>
#include <algorithm>
#include <cmath>
#include <iostream>

class Location
{
    public:
        double distance_weight = 10;
        Location(double lat, double lon)
        {
            latitude = lat;
            longitude = lon;
        }

        double get_latitude() const
        {
            return latitude;
        }
        double get_longitude() const
        {
            return longitude;
        }

        void add_connection(Location * loc)
        {
            if (std::find(connections.begin(), connections.end(), loc) == connections.end())
                connections.push_back(loc);
        }

        // Calculates the Haversine distance between this and other
        double distance(const Location& other) const
        {
            double lon1 = longitude * (3.141592653) / 180;
            double lat1 = latitude * (3.141592653) / 180;
            double lon2 = other.longitude * (3.141592653) / 180;
            double lat2 = other.latitude * (3.141592653) / 180;
            double dlat = lat2 - lat1;
            double dlon = lon2 - lon1;
            double a = sin(dlat / 2) * sin(dlat / 2) + cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
            double c = 2 * asin(sqrt(a));
            double r = 6371; // Radius of earth in kilometers.
            return r * c;
        }

        std::vector<Location*> get_connections()
        {
            return connections;
        }

    protected:

    private:
        double latitude;
        double longitude;

        std::vector<Location*> connections;

};
std::ostream& operator<< (std::ostream& out, const Location& l)
{
    out << "(" << l.get_latitude() << ", " << l.get_longitude() << ")";
    return out;
}

#endif // LOCATION_H
