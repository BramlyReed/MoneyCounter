//
//  AuthViewController.swift
//  MoneyCounter
//
//  Created by Stanislav on 28.04.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import RealmSwift

class AuthViewController: UIViewController {
    var signUp: Bool = true {
        willSet {
            if newValue {
                signUpMode()
            } else {
                signInMode()
            }
        }
    }
    
    var userID: UserID?
    
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var loginfield: UITextField!
    
    @IBOutlet weak var passwordfield: UITextField!
    
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var namefield: UITextField!
    
    @IBOutlet weak var loadindicator: UIActivityIndicatorView!
    @IBOutlet weak var surnamelabel: UILabel!
    @IBOutlet weak var surnamefield: UITextField!
    
    @IBOutlet weak var haveregistr: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadindicator.stopAnimating()
    }
    
    
    @IBAction func changeForm(_ sender: Any) {
        signUp = !signUp
    }
    
    
    func signInMode() {
        namefield.isHidden = true
        surnamefield.isHidden = true
        namelabel.isHidden = true
        surnamelabel.isHidden = true
        titlelabel.text = "Вход"
        haveregistr.setTitle("Зарегистрироваться", for: .normal)
    }
    
    func signUpMode() {
        namefield.isHidden = false
        surnamefield.isHidden = false
        namelabel.isHidden = false
        surnamelabel.isHidden = false
        titlelabel.text = "Регистрация"
        haveregistr.setTitle("Уже зарегистрированы?", for: .normal)
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Все поля должны быть заполнены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func SIGNIN(_ sender: Any) {
        
        let name = namefield.text!
        let surname = surnamefield.text!
        let email = loginfield.text!
        let password = passwordfield.text!
        
        if signUp == true {
            if name.isEmpty || email.isEmpty || password.isEmpty || surname.isEmpty {
                showAlert()
            }
            else {
                self.loadindicator.startAnimating()
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard result != nil, (error == nil) else { return print("error: \(error)") }
                    
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name":name,"surname":surname,"email":email,"uid": result!.user.uid]){(error) in
                        
                        if error != nil{
                            print("eror: \(error)")
                        }
                        else{
                            self.userID = UserID(id: (result!.user.uid))
                            DBManager.saveID(self.userID!)
                            self.loadindicator.stopAnimating()
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                    }
                    
                }
            }
        }
        else {
            if email.isEmpty || password.isEmpty {
                showAlert()
            } else {
                self.loadindicator.startAnimating()
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    guard result != nil, (error == nil) else { return }
                    self.userID = UserID(id: result!.user.uid)
                    //DBManager.saveID(self.userID!)
                    self.loadindicator.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
}

