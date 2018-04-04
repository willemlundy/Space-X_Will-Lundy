//
//  APIManager.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation
import SwiftyJSON

enum LaunchSearchAPI: String {
    case LatestLaunch = "https://api.spacexdata.com/v2/launches/latest"
    case PastLaunches = "https://api.spacexdata.com/v2/launches"
    case UpcomingLaunches = "https://api.spacexdata.com/v2/launches/upcoming"
    case AllLaunches = "https://api.spacexdata.com/v2/launches/all"
    
}

class APIManager {
    
    func getLaunchStorage(launchSearch: String, callback: @escaping (_ allLaunches: SpaceXLaunches?, _ error: Error?) -> Void) {
        
        
        HTTPClient.shared.getJSON(url: launchSearch) {
            (json, error) in
            // Do we have an error
            guard error == nil else {
                callback(nil, error)
                return
            }
            
            // Do we have data
            if let json = json {
                
                let spaceXLaunches = SpaceXLaunches(json: json)
                callback(spaceXLaunches, error)
            }
        }
        
    }
    
    
}
