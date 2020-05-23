//
//  PickerVC.swift
//  MoneyCounter
//
//  Created by Stanislav on 22.04.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import UIKit

class PickerVC: UIViewController{
    
    var window: UIWindow?
    @IBOutlet weak var AddButton: UIButton!
    var waste: Waste?
    @IBOutlet weak var Picker1: UIPickerView!
    @IBOutlet weak var MoneySum: UITextField!
    
    @IBOutlet weak var pickedlabel: UILabel!
    let userID = realm.objects(UserID.self)
    
    let GoalSource = ["Еда", "Обязательные платежи", "Штрафы", "Отдых", "Транспорт", "Подарки", "Прочее"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickedlabel.isHidden = true
        Picker1.delegate = self
   
    }
    
    @IBAction func backbutton(_ sender: Any) {
        print("GO BACK")
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saving(_ sender: Any) {
        
        let uid = userID.last!.id
        let date = Date()
        let MIN: Float! = 0
        let MAX: Float! = 1000000
        let pick = pickedlabel.text!
        let calendar = Calendar.current
        let d = calendar.component(.day, from: date)
        let m = calendar.component(.month, from: date)
        let y = calendar.component(.year, from: date)
        let amount = Float(MoneySum.text!)
        if MoneySum.text == "" || pick.isEmpty {
            print("FILL EVERITHING")
            showAlert()
        }
        else if amount == nil {
            print("INCORRECT VALUE")
            showAlert2()
        }
        else if amount! <= MIN! || amount! > MAX! {
            print("INCORRECT VALUE")
            showAlert2()
        }
        else{
            waste = Waste(id:uid, day: "\(d)", month: "\(m)", year: "\(y)", goal: pick, amount: amount!)
            DBManager.saveWaste(waste!)
            print("ALL DONE")
            dismiss(animated: true, completion: nil)
        }
    }
    func showAlert() {
        let alert = UIAlertController(title: "Заполните все поля", message: "Все поля должны быть заполнены", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showAlert2() {
        let alert = UIAlertController(title: "Нарушен диапазон", message: "(0 ... 1,000,000]", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension PickerVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GoalSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GoalSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedlabel.text = GoalSource[row]
        pickedlabel.isHidden = false
    }
    
}
