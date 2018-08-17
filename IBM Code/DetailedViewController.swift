//
//  DetailedViewController.swift
//  IBM Code
//
//  Created by Arfhan Ahmad on 8/16/18.
//  Copyright © 2018 Arfhan Ahmad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class DetailedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Location: UILabel!
    
    var holder = [DetailedModel]()
    var IdLabel: String = ""
    var cityLabel: String?
    var date: String?
    var minTemp: Double?
    var maxTemp: Double?
    var currentTemp: Double?
    var humidity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocationData()
        self.Location.text = cityLabel
    }
    
    // Function to fetch the data from URL (passed the id from the first view controller)
    func fetchLocationData() {
        let url = URL(string: "https://www.metaweather.com/api/location/\(IdLabel)/")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSON(data: data)
                for item in json["consolidated_weather"].arrayValue {
                    self.holder.append(DetailedModel(json: item))
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holder.count
    }
    
    //Cusomized cell using json Data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! DetailedTableViewCell
        
        cell.dateCreated.text = holder[indexPath.row].date
        cell.maximumTemperature.text = "\(Int(round(holder[indexPath.row].maxTemp!))) ℃"
        cell.minimumTemp.text = "\(Int(round(holder[indexPath.row].currentTemp!))) ℃"
        cell.humidity.text = holder[indexPath.row].humidity
        cell.currentTemperature.text = "\(Int(round(holder[indexPath.row].minTemp!))) ℃"
        
             return cell
    }
}
