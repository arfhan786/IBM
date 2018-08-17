//
//  DetailedModel.swift
//  IBM Code
//
//  Created by Arfhan Ahmad on 8/16/18.
//  Copyright © 2018 Arfhan Ahmad. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DetailedModel {
    var date: String?
    var minTemp: Double?
    var maxTemp: Double?
    var humidity: String?
    var currentTemp:Double?
    
    init() {
        
    }
    init(json: JSON) {
        
        date = json["applicable_date"].stringValue
        minTemp = json["min_temp"].doubleValue
        maxTemp = json["max_temp"].doubleValue
        humidity = json["humidity"].stringValue
        currentTemp = json["the_temp"].doubleValue
        
        
    }
}
