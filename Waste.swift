//
//  Waste.swift
//  MoneyCounter
//
//  Created by Stanislav on 23.04.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import Foundation
import RealmSwift

class Waste: Object{
    
    @objc dynamic var id: String = ""
    @objc dynamic var day: String = ""
    @objc dynamic var month: String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var goal: String = ""
    @objc dynamic var amount: Float = 0
    
    convenience init(id: String, day: String, month: String, year: String, goal: String, amount: Float) {
        self.init()
        self.id = id
        self.day = day
        self.month = month
        self.year = year
        self.goal = goal
        self.amount = amount
    }
}
