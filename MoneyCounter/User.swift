//
//  User.swift
//  MoneyCounter
//
//  Created by Stanislav on 23.04.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var name: String
    var surname: String
    
    init(data: JSON) {
        self.name = data["name"] as! String
        self.surname = data["surname"] as! String
    }
    
}
