//
//  JsonDataModel.swift
//  IBM Code
//
//  Created by Arfhan Ahmad on 8/15/18.
//  Copyright © 2018 Arfhan Ahmad. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JsonDataModel {
    var locatoionType:String?
    var locationTitle:String?
    var locationId:String?
    
    init() {
        
    }
    init(json: JSON) {
        
        locatoionType = json["location_type"].stringValue
        locationId = json["woeid"].stringValue
        locationTitle = json["title"].stringValue
        
    }
}
























