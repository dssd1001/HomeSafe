from xml.etree import cElementTree as ET


def extract_intersections(osm, verbose=True):
    """
    This function takes an osm file as input, and returns the list of all intersections
    by crossreferencing nodes. The osm files are obtained via OpenStreetMap.
    e.g. extract_intersections('Berkeley.osm')

    Much credit of this code goes to StackOverflow user Kotaro at
    http://stackoverflow.com/users/684592/kotaro
    """
    tree = ET.parse(osm)
    root = tree.getroot()
    counter = {}
    for child in root:
        if child.tag == 'way':
            for item in child:
                if item.tag == 'nd':
                    nd_ref = item.attrib['ref']
                    if nd_ref not in counter:
                        counter[nd_ref] = 0
                    counter[nd_ref] += 1

    # Find nodes that are shared with more than one way, which
    # correspond to intersections
    intersections = filter(lambda x: counter[x] > 1,  counter)

    # Extract intersection coordinates
    intersectionList = []
    for child in root:
        if child.tag == 'node' and child.attrib['id'] in intersections:
            coordinate = child.attrib['lat'] + ',' + child.attrib['lon']
            if verbose:
                print(coordinate)
            intersectionList.append(coordinate)

    return intersectionList

