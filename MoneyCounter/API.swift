//
//  API.swift
//  MoneyCounter
//
//  Created by Stanislav on 04.05.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import Foundation
import RealmSwift



typealias JSON = [String : Any]

//var userID: Results<UserID>!
//userID.realm?.objects(userID)

enum API {
    
    static var baseURL: String {
        return "https://moneycount2-d4a21.firebaseio.com/users"
        
    }
    static func loadUserData(userID: String ,completion: @escaping (User) -> Void) {
        let url = URL(string: baseURL + ".json")!
        let request = URLRequest(url: url)
        
        let user = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! JSON
                else { return print("FALL HERE")}
            
            let userJSON = json[userID] as! JSON
            let user = User(data: userJSON)
            DispatchQueue.main.async {
                completion(user)
            }
        }
        user.resume()
    }
    

 
}
