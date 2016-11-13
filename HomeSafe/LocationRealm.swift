//
//  LocationRealm.swift
//  Realm
//
//  Created by Aaron Lee on 11/12/16.
//  Copyright © 2016 Aarontlee. All rights reserved.
//

import Foundation
import RealmSwift

var realm = Realm()



class Location : Object {
    var name: String
    var heuristicVal: [String:Float] = [
        "Theft" : 7,
        "Burglary" : 10,
        "Assault" : 20,
        "Shooting" : 50,
        "Suspicious Behavior" : 1,
        "Fire" : 50.0
    ]
    var radius: [String:Float] = [
        "Theft" : 0.2,
        "Burglary" : 0.2,
        "Assault" : 0.35,
        "Shooting" : 0.70,
        "Suspicious Behavior" : 0.025,
        "Fire" : 0.05
    ]
}
