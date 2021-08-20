//
//  PieChart.swift
//  MoneyCounter
//
//  Created by Stanislav on 11.05.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//
import Charts
import UIKit

class PieChart: UIViewController {
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var datalabel: UILabel!

    let userID = realm.objects(UserID.self)
    var colors:[UIColor] = [UIColor.black, UIColor.orange, UIColor.init(red: 0, green: 0, blue: 128, alpha: 1), UIColor.magenta, UIColor.purple, UIColor.brown, UIColor.init(red: 128, green: 0, blue: 0, alpha: 1)]
    
    var EdaData = PieChartDataEntry(value: 0, label: nil)
    var ObPlatz = PieChartDataEntry(value: 0, label: nil)
    
    var Shtrafs = PieChartDataEntry(value: 0, label: nil)
    
    var Otduh = PieChartDataEntry(value: 0, label: nil)
    
    
    var Transports = PieChartDataEntry(value: 0, label: nil)
    
    var Podarki = PieChartDataEntry(value: 0, label: nil)
    
    var Prochee = PieChartDataEntry(value: 0, label: nil)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView.chartDescription?.text = ""
        let calendar = Calendar.current
        let date = Date()
        var mmm = calendar.component(.month, from: date)
        var yyy = calendar.component(.year, from: date)
        if mmm == 1{
            yyy = yyy - 1
            mmm = 12
        }
        else {
            mmm = mmm - 1
        }
        
        let uid = userID.last!.id
        let people = try! realm.objects(Waste.self)
        
        var pr1: Double = 0
        var pr2: Double = 0
        var pr3: Double = 0
        var pr4: Double = 0
        var pr5: Double = 0
        var pr6: Double = 0
        var pr7: Double = 0
        
        //eda
        
        let filtrn = people.filter("id == '\(uid)' && month = '\(mmm)' && year = '\(yyy)'")
        if filtrn.count == 0{
            showAlert()
        }
        
        let filtr1 = people.filter("id == '\(uid)' && goal == 'Еда' && month = '\(mmm)' && year = '\(yyy)'")
        if filtr1.count == 0{
            print("НЕТ данных о еде!")
        }
        else{
            for product in filtr1{
                pr1 = pr1 + Double(product.amount)
            }
        }
        EdaData.value = pr1
        if EdaData.value != 0{
            EdaData.label = "Еда"
        }
        
        //obz platez
        let filtr2 = people.filter("id == '\(uid)' && goal == 'Обязательные платежи' && month = '\(mmm)' && year = '\(yyy)'")
        if filtr2.count == 0{
            print("НЕТ данных об обязательных платежах!")
        }
        else{
            for product in filtr2{
                pr2 = pr2 + Double(product.amount)
            }
        }
        ObPlatz.value = pr2
        if ObPlatz.value != 0{
            ObPlatz.label = "Об.платежи"
        }
        
        //штрафы
        
        let filtr3 = people.filter("id == '\(uid)' && goal == 'Штрафы' && month = '\(mmm)' && year = '\(yyy)'")
        if filtr3.count == 0{
            print("НЕТ данных о штрафах!")
        }
        else{
            for product in filtr3{
                pr3 = pr3 + Double(product.amount)
            }
        }
        Shtrafs.value = pr3
        if Shtrafs.value != 0{
            Shtrafs.label = "Штрафы"
        }
        
        let filtr4 = people.filter("id == '\(uid)' && goal == 'Отдых' && month = '\(mmm)' && year = '\(yyy)'")
        if filtr4.count == 0{
            print("НЕТ данных об отдыхе!")
        }
        else{
            for product in filtr4{
                pr4 = pr4 + Double(product.amount)
            }
        }
        Otduh.value = pr4
        if Otduh.value != 0{
            Otduh.label = "Отдых"
        }
        
        let filtr5 = people.filter("id == '\(uid)' && goal == 'Транспорт' && month = '\(mmm)' && year = '\(yyy)'")
        if filtr5.count == 0{
            print("НЕТ данных о транспорте!")
        }
        else{
            for product in filtr5{
                pr5 = pr5 + Double(product.amount)
            }
        }
        Transports.value = pr5
        if Transports.value != 0{
            Transports.label = "Транспорт"
        }
        
        let filtr6 = people.filter("id == '\(uid)' && goal == 'Подарки' && month = '\(mmm)' && year = '\(yyy)'")
        if filtr6.count == 0{
            print("НЕТ данных о подарках!")
        }
        else{
            for product in filtr6{
                pr6 = pr6 + Double(product.amount)
            }
        }
        Podarki.value = pr6
        if Podarki.value != 0{
            Podarki.label = "Подарки"
        }
        
        let filtr7 = people.filter("id == '\(uid)' && goal == 'Прочее' && month = '\(mmm)' && year = '\(yyy)'")
        if filtr7.count == 0{
            print("НЕТ данных о прочее!")
        }
        else{
            for product in filtr7{
                pr7 = pr7 + Double(product.amount)
            }
        }
        Prochee.value = pr7
        if Prochee.value != 0{
            Prochee.label = "Прочее"
        }
        
        numberOfDownloadsDataEntries = [EdaData, ObPlatz, Shtrafs, Otduh, Transports, Podarki, Prochee]
        updatePieChart()
        setlabel()
    }

    func updatePieChart(){
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = colors
        pieChartView.data = chartData
    }
    func setlabel(){
        let calendar = Calendar.current
        let date = Date()
        let mon:[String] = ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"]
        var mmm = calendar.component(.month, from: date)
        var yyy = calendar.component(.year, from: date)
        if mmm == 1{
            yyy = yyy - 1
            mmm = 12
        }
        else {
            mmm = mmm - 1
        }
        self.datalabel.text = "\(mon[mmm-1]) \(yyy)"
        datalabel.alpha = 1
        print("\(mon[mmm-1]) \(yyy)")
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Нет данных", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
