//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Peter Sivak on 10/16/24.
//

import Foundation

struct Athlete {
    var name: String
    var age: Int
    var league: String
    var team: String
    
    var description: String {
        return "\(name) is \(age) years old and plays for the \(team) in the \(league)."
    }
}

