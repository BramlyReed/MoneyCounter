//
//  HistoryControlletViewController.swift
//  MoneyCounter
//
//  Created by Stanislav on 18.04.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
class HistoryController:UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablelist: UITableView!
    let userID = realm.objects(UserID.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let uid = userID.last!.id
        let people = try! realm.objects(Waste.self)
        var filtr = people.filter("id == '\(uid)'")
        if filtr.count == 0{
            showAlert()
        }
        return filtr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let uid = userID.last!.id
        let people = try! realm.objects(Waste.self)
        var filtr = people.filter("id == '\(uid)'")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryCell
        tableView.rowHeight = 90
        cell.goalamount.text = filtr[indexPath.row].goal + ":  " + "\(filtr[indexPath.row].amount)" + " RUB"
        cell.datelabel.text = filtr[indexPath.row].day + "." + filtr[indexPath.row].month + "." + filtr[indexPath.row].year
        return cell
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Нет данных!", message: "Отсутствуют записи в БД", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        }
}
