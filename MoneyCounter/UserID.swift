//
//  UserID.swift
//  MoneyCounter
//
//  Created by Stanislav on 03.05.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import Foundation
import RealmSwift

class UserID: Object {
    @objc dynamic var id: String = ""
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}
