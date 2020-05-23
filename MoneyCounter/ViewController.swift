//
//  ViewController.swift
//  MoneyCounter
//
//  Created by Stanislav on 06.04.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RealmSwift
import Realm
class ViewController: UIViewController {

    @IBOutlet weak var welocomelabel: UILabel!
    
    @IBOutlet weak var loadindicator: UIActivityIndicatorView!
    let userID = realm.objects(UserID.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
            print("IT DELETED")
        }*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userID.count != 0{
            
        let uid = userID.last!.id
        print("uid: \(uid)")
            API.loadUserData(userID: uid) { user in
                self.loadindicator.startAnimating()
                self.welocomelabel.text = "Добро пожаловать, \(user.name) \(user.surname)"
                self.loadindicator.stopAnimating()
            }
            
        }
        else {print("I'm empty")}
    }

    @IBAction func exitbutton(_ sender: Any) {
        self.loadindicator.startAnimating()
        do{
            DBManager.deletett(userID.last!)
            try Auth.auth().signOut()
            welocomelabel.text = ""
        }
        catch{
            print("errors")
        }
    }
}

