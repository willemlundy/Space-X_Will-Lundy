//
//  SpaceXLaunches.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SpaceXLaunches {
    var launches: [Launch] = []
    
    init() {
    }
    
    init?(json: JSON) {
        guard let launches = json.array else {
            return nil
        }
        
        for launch in launches {
            self.launches.append(Launch(json: launch))
        }
    }
}

extension SpaceXLaunches: SearchModelProtocol {
    
}

extension SpaceXLaunches: ListModelProtocol {
    
}
