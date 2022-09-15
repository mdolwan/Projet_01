//
//  Military.swift
//  Last New Version
//
//  Created by Mohammad Olwan on 18/07/2021.
//

import Foundation

public class Player {
    
    var name: String
    var team: [Soldier]
    
    init(name: String = "", team: [Soldier] = []) {
        self.name = name
        self.team = team
    }
}

