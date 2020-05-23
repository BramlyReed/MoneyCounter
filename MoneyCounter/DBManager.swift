//
//  DBManager.swift
//  MoneyCounter
//
//  Created by Stanislav on 03.05.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class DBManager {
    static func saveWaste(_ waste: Waste) {
        try! realm.write {
            realm.add(waste)
        }
    }
    static func saveID(_ userID: UserID) {
        try! realm.write {
            realm.add(userID)
        }
    }
    static func deletett(_ user: UserID) {
        try! realm.write {
            realm.delete(user)
        }
    }
}
