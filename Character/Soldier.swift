//
//  soldier.swift
//  Last New Version
//
//  Created by Mohammad Olwan on 18/07/2021.
//

import Foundation

public class Soldier {
    
    var type: String
    var name: String
    var weapon: Weapon
    var pointLife : Int
    
    init(type: String = "", name: String = "", weapon: Weapon = Sword(), pointLife: Int = 0) {
        self.type = type
        self.name = name
        self.weapon = weapon
        self.pointLife = pointLife
    }
    
    func heal(){
        self.pointLife += 50
    }
    
    func attack(soldier: Soldier) {
        soldier.pointLife -= self.weapon.weaponPower
    }
}
