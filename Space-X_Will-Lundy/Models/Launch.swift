//
//  Launch.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SwiftyJSON

struct Launch: ListCellModelProtocol {
    let rocket_name: String
    let flight_number: Int
    let launch_year: String
    let launch_date_local: String
    let launch_date_utc: String
    let details: String
    let site_name_long: String
    var imageLink: String
    
    // Given more time I would have built in more error checking on the structure of the json and the range of the values
    
    init(json: JSON) {
        //print(json)
        self.rocket_name = json["rocket"]["rocket_name"].stringValue
        self.flight_number = json["flight_number"].intValue
        self.launch_year = json["launch_year"].stringValue
        self.launch_date_local = json["launch_date_local"].stringValue
        self.launch_date_utc = json["launch_date_utc"].stringValue
        self.details = json["details"].stringValue
        self.site_name_long = json["launch_site"]["site_name_long"].stringValue
        self.imageLink = json["links"]["mission_patch"].stringValue
        
    }
}
