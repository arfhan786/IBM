//
//  ViewController.swift
//  IBM Code
//
//  Created by Arfhan Ahmad on 8/15/18.
//  Copyright © 2018 Arfhan Ahmad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataHolder = [JsonDataModel]()
    @IBOutlet weak var tableView: UITableView!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTypeTableViewCell
        cell.locationId.text = dataHolder[indexPath.row].locationId
        cell.locationType.text = dataHolder[indexPath.row].locatoionType
        cell.locationTitle.text = dataHolder[indexPath.row].locationTitle
        return cell
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocationData()
    }
    // Function to fetch data from URL
    func fetchLocationData() {

        let url = URL(string: "https://www.metaweather.com/api/location/search/?lattlong=40.678177,-73.944160")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSON(data: data)
                for printer in json.arrayValue {
                   self.dataHolder.append(JsonDataModel(json: printer))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    //Segue to send id and location information to next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "info" {
            if let destination = segue.destination as? DetailedViewController {
                destination.IdLabel = dataHolder[tableView.indexPathForSelectedRow!.row].locationId!
                destination.cityLabel = dataHolder[tableView.indexPathForSelectedRow!.row].locationTitle!                
            }
        }
    }
}

