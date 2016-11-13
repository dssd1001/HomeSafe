import collections
from math import radians, cos, sin, asin, sqrt

### To do bit processing stuff ###

def binary(i):
    """Gives the 32-bit binary of i
    >>> binary(15)
    [True, True, True, True, False, False, ...]
    """
    ret = [False] * 32
    is_neg = False
    if i < 0:
        is_neg = True
        i = -i
    counter = 0
    while i > 0:
        ret[counter] = bool(i % 2)
        i //= 2
        counter += 1
    if is_neg:
        # Flip all the bits
        for i in range(len(ret)):
            ret[i] = not ret[i]
        
        # Now add one to the result 
        carry = ret[0]
        counter = 0
        ret[counter] = not ret[counter]
        while carry and counter < 31:
            counter += 1
            carry = ret[counter]
            ret[counter] = not ret[counter]
    return ret
def invert(s):
    """Invert the bits of s"""
    for i in range(len(s)):
        s[i] = not s[i]

def left_shift(s):
    for i in range(len(s) - 1, 0, -1):
        s[i] = s[i-1]
    s[0] = False
### --- END --- ###

class NoPathError(Exception):
    pass

class Location:
    """A class that represents a location on a map"""
    distance_weight = 10
    def __init__(self, lat, long):
        """We want a latitude and longitude"""
        self.lat = lat
        self.long = long
        self.connections = []
    
    def distance(self, other):
        """Computes the distance in kilometers between two Location objects.
        
        Uses Haversine distance.
        """
        lon1, lat1, lon2, lat2 = map(radians, [self.lat, self.long, other.lat, other.long])
        dlon = lon2 - lon1
        dlat = lat2 - lat1
        a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
        c = 2 * asin(sqrt(a))
        r = 6371 # Radius of earth in kilometers. 
        return r * c
    
    def risk(self, other, risks):
        """Computes the risk between two Location objects. 
        Adds the normal distance with the risk defined by 
        
        v * (r/d)^2
        v -- the value of the event
        r -- the radius constant
        d -- the distance away from the event 
        """
        midpoint = Location( (self.lat + other.lat) / 2, (self.long + other.long) / 2)
        # We now compute the distance from midpoint to the location of the risk. 
        ret_value = 0
        for event in risks.events:
            d = Location.distance(midpoint, event.location)
            r = event.radius
            danger = event.danger
            ret_value += danger * (r / d) * (r / d)
        return ret_value + Location.distance(self, other) * Location.distance_weight
    
    def add_connection(self, locs):
        """Adds a Location object that can be reached by one block on a street"""
        for loc in locs:
            if loc not in self.connections:
                self.connections.append(loc)
                loc.add_connection([self])
    
    def __repr__(self):
        return '(' + str(self.lat) + ", " + str(self.long) + ')'
            
class Event:
    """An event object that represents something happening at a certain location"""
    def __init__(self, loc, danger, radius):
        self.location = loc
        self.danger = danger
        self.radius = radius

class Risks:
    """A risks collection that collects all the events."""
    def __init__(self, events=[]):
        self.events = events
    
    def push_event(self, loc, danger, radius):
        self.events.append(Event(loc, danger, radius))
    
def heuristic_cost_estimate(loc1, loc2):
    """Just returns the simple distance between loc1 and loc2"""
    return Location.distance(loc1, loc2) * Location.distance_weight
    
def A(start, goal):
    # The set of nodes already evaluated.
    closedSet = set()
    # The set of currently discovered nodes still to be evaluated.
    # Initially, only the start node is known.
    openSet = {start}
    # For each node, which node it can most efficiently be reached from.
    # If a node can be reached from many nodes, cameFrom will eventually contain the
    # most efficient previous step.
    cameFrom = {}

    # For each node, the cost of getting from the start node to that node.
    gScore = collections.defaultdict(lambda : float('inf'))
    #The cost of going from start to start is zero.
    gScore[start] = 0 
    # For each node, the total cost of getting from the start node to the goal
    # by passing by that node. That value is partly known, partly heuristic.
    fScore = collections.defaultdict(lambda : float('inf'))
    # For the first node, that value is completely heuristic.
    fScore[start] = heuristic_cost_estimate(start, goal)

    while openSet:
        current = min(openSet, key = lambda x : fScore[x]) # the node in openSet with the lowest fScore value
        if current == goal:
            return reconstruct_path(cameFrom, current)

        openSet.remove(current)
        closedSet.add(current)
        for neighbor in current.connections:
            if neighbor in closedSet:
                continue		# Ignore the neighbor which is already evaluated.
            # The distance from start to a neighbor
            tentative_gScore = gScore[current] + Location.risk(current, neighbor, risks)
            if neighbor not in openSet:	# Discover a new node
                openSet.add(neighbor)
            elif tentative_gScore >= gScore[neighbor]:
                continue		# This is not a better path.

            # This path is the best until now. 
            cameFrom[neighbor] = current
            gScore[neighbor] = tentative_gScore
            fScore[neighbor] = gScore[neighbor] + heuristic_cost_estimate(neighbor, goal)
    
    raise NoPathError

def encoded_polyline_algorithm_format(locations):
    """Takes in location objects and returns an encoded string for the polyline algorithm 
    >>> l1 = Location(38.5, -120.2)
    >>> l2 = Location(40.7, -120.95)
    >>> l3 = Location(43.252, -126.453)
    >>> encoded_polyline_algorithm_format([l1, l2, l3])
    '_p~iF~ps|U_ulLnnqC_mqNvxq`@'
    """
    # First, take the differences between consecutive locations
    for i in range(len(locations) - 1, 0, -1):
        locations[i] = (locations[i].lat - locations[i-1].lat, locations[i].long - locations[i-1].long)
    # Multiply everything by 10^5
    for i in range(len(locations)):
        locations[i] = (round(1e5 * locations[i][0]), round(locations[i][1] * 1e5))
        if locations[i][0] < 0:
            is_neg0 = True
        if locations[i][1] < 0:
            is_neg1 = True
        # Each of these will be bit arrays 
        lat, long = binary(locations[i][0]), binary(locations[i][1])
        left_shift(lat)
        left_shift(long)
        if is_neg0:
            invert(lat)
        if is_neg1:
            invert(long)
        lat_chunk = [lat[5 * i : 5 * i + 5] for i in range(6)]
        
def reconstruct_path(cameFrom, current):
    total_path = [current]
    while current in cameFrom.keys():
        current = cameFrom[current]
        total_path.append(current)
    total_path.reverse()
    for i in range(len(total_path)):
        total_path[i] = (total_path[i].lat, total_path[i].long)
    return encoded_polyline_algorithm_format(total_path)