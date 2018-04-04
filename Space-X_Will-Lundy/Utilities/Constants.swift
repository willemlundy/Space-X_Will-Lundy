//
//  Constants.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/4/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation

struct Constants {
    // Enums for namespacing constants.  Given more time I would move all the things here
    
    enum LaunchCoordinator {
        static let serviceUnavailable = "Space X Mars server not responding"
    }
    
    enum Search {
        static let nibName = "Search"
        static let title = "Launch Search"
        static let fourDigitYearMessage = "Make sure you enter a four digit year or start and end dates"
        static let noLaunchesMessage = "No Space X Launches in "
        static let followFormat = "Both dates must follow YYYY-MM-DD format"
        static let fourDigitMessage = "Please enter a four digit year"
        static let firstSpaceLaunch = 2006
        static let furthestSpaceLaunch = 2019
    }
    
    enum List {
        static let nibName = "List"
        static let title = "Search Results"
        
        enum ListCell {
            static let nibName = "ListTableViewCell"
            static let reuseID = "LaunchItem"
        }
    }
    
    enum Detail {
        static let nibName = "Detail"
    }
}
