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
        "Theft" : 1.0,
        "Burglary" : 2.0,
        "Assault" : 3.0,
        "Shooting" : 7.0,
        "Suspicious Behavior" : 0.25,
        "Fire" : 5.0
    ]
    var radius: [String:Float] = [
        "Theft" : 0.05,
        "Burglary" : 0.1,
        "Assault" : 0.2,
        "Shooting" : 0.4,
        "Suspicious Behavior" : 0.003,
        "Fire" : 0.05
    ]
}
