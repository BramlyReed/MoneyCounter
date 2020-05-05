//
//  PickerVC.swift
//  MoneyCounter
//
//  Created by Stanislav on 22.04.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import UIKit

class PickerVC: UIViewController{
    
    @IBOutlet weak var AddButton: UIButton!
    var waste: Waste?
    @IBOutlet weak var Picker1: UIPickerView!
    @IBOutlet weak var MoneySum: UITextField!
    
    let GoalSource = ["Продукты", "Напитки", "Ком платежи", "Налоги", "Штрафы", "Хобби" , "Путешествия", "Транспорт", "Подарки", "Прочее"]
    
    let amounts = [50, 100, 150, 200, 250, 300, 350, 500]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Picker1.delegate = self
   
    }
    
    var currentDate: String {
        get {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            return dateFormatter.string(from: date)
        }
    }
    
    func getWaste() {
        
        let pickedAmount = Picker1.selectedRow(inComponent: 0)
        let pickedGoal = Picker1.selectedRow(inComponent: 1)
        
        waste = Waste(type: GoalSource[pickedGoal], summa: amounts[pickedAmount], date: currentDate)
        
        //DBManager.saveDrink(drink!)
    }}


extension PickerVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return GoalSource.count
        } else {
            return amounts.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return GoalSource[row]
        } else {
            return ("\(String(amounts[row])) eur")
        }
    }
    
}
