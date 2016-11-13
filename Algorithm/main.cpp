#include <iostream>
#include <fstream>
#include <string>
#include <utility>
#include "main.h"
using namespace std;

int main()
{
    ifstream fin;
    fin.open("inputdata.txt");
    City berkeley;

    for (int i = 0; i < 28; i++)
    {
        double x, y;
        vector< pair<double, double> > inters;
        while (true)
        {
            fin >> x;
            if (x == 696969) {
                break;
            }

            fin >> y;
            inters.push_back(make_pair(x, y));
        }
        berkeley.push_street(inters);
    }
    fin.close();
    vector<Location*> i = berkeley.get_intersections();
    berkeley.push_event(37.876978, -122.260241, 10, 0.5);
    cout.precision(10);
    cout << *(i[0]) << endl;
    cout << *(i[12]) << endl;
    vector< pair<double, double> > path = berkeley.Astar(37.877302, -122.257087, 37.875479, -122.258235);
    for (int i = 0; i < path.size(); i++)
    {
        cout << path[i].first << " " << path[i].second << endl;
    }
    return 0;
}
