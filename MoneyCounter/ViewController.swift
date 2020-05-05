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
class ViewController: UIViewController {

    @IBOutlet weak var usdfield: UILabel!
    
    @IBOutlet weak var eurofield: UILabel!
    @IBOutlet weak var loadindicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.loadindicator.stopAnimating()
    }

    @IBAction func exitbutton(_ sender: Any) {
        self.loadindicator.startAnimating()
        do{
            try Auth.auth().signOut()
            self.loadindicator.stopAnimating()
        }
        catch{
            print("errors")
        }
    }
    
}

