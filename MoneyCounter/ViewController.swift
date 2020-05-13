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
    //let Wasteid = realm.objects(Waste.self)
    let userID = realm.objects(UserID.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        script()
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
                //self.script()
            }
            
        }
        else {print("I'm empty")}
    }

    @IBAction func exitbutton(_ sender: Any) {
        self.loadindicator.startAnimating()
        do{
            DBManager.deletett(userID.last!)
            try Auth.auth().signOut()
            welocomelabel.text = "Добро пожаловать, "
            //self.loadindicator.stopAnimating()
        }
        catch{
            print("errors")
        }
    }
    func script(){
        ///let waste = Waste(id: userID.last!.id, day: "8",month: "5", year: "2020",goal: "Подарки", amount: "3000")
        //DBManager.saveWaste(waste)
        /*let uid = userID.last!.id
        let people = try! realm.objects(Waste.self)
        var filtr = people.filter("id == '\(uid)'")
        for person in people {
            print("\(person.id)" + "\(person.day)" + "\(person.month)" + "\(person.year)" + "\(person.goal)" + "\(person.amount)")
        //print("\(person.id)")
        }*/
        print("IS IT ALL")
    }
    
    
    
}

