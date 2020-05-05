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
    
    @objc dynamic var type: String = ""
    @objc dynamic var summa: Int = 0
    @objc dynamic var date: String = ""
    
    convenience init(type: String, summa: Int, date: String){
        self.init()
        self.type = type
        self.summa = summa
        self.date = date
    }
    
}
