//
//  ExchangeRateTableViewController.swift
//  MoneyCounter
//
//  Created by Stanislav on 05.05.2020.
//  Copyright © 2020 Stanislav. All rights reserved.
//

import UIKit

class ExchangeRateTableViewController: UITableViewController {
    
    var exchangeRates = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        var API_KEY: String { return "0ada4d168c5d028001b5bc53b6f6108f" }
        let apiEndPoint = "http://data.fixer.io/api/latest?access_key=\(API_KEY)"
        guard let url = URL(string: apiEndPoint) else {return}
        let task = URLSession.shared.dataTask(with: url){ (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {return}
            
            if let httpResponse = response as? HTTPURLResponse{
                guard httpResponse.statusCode == 200 else {return}
                print("Everything is OK")
            }
            
            guard let data = data else {return}
            
            do{
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {return}
                print(dict.description)
                guard let rates = dict["rates"] as? [String: Double], let base = dict["base"] as? String, let date = dict["date"] as? String else {return}
                let currencies = rates.keys.sorted()
                for currency in currencies{
                    if let rate = rates[currency]{
                        self.exchangeRates.append("1 \(base) = \(rate) \(currency)")
                        }
                    }
                OperationQueue.main.addOperation ({
                    self.navigationController?.navigationBar.topItem?.title = "updated on \(date)"
                    self.tableView.reloadData()
                })
                }
            catch{
                print("Some error")
            }
            }
        task.resume()
            
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exchangeRates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "rates", for: indexPath)
        
        cell.textLabel?.text = exchangeRates[indexPath.row]
        return cell
    }
        

}
