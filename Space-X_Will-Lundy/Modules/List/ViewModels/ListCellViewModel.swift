//
//  ListCellViewModel.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/3/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation

protocol ListCellModelProtocol {
    var rocket_name: String { get }
    var flight_number: Int { get }
    var launch_year: String { get }
    var launch_date_local: String { get }
    var launch_date_utc: String { get }
    var details: String { get }
    var site_name_long: String { get }
    var imageLink: String { get }
}

protocol ListCellViewModelDelegate: class {

}

protocol ListCellViewModelInterface {
    

    var rocketName: String { get }
    var flightNo: String { get }
    var flightDate: String { get }
    var launchSite: String { get }
    var launchImage: String { get }

}

class ListCellViewModel: ListCellViewModelInterface {
    
    let listCellModel: ListCellModelProtocol
    
//    let displayDateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        let localDate = formatter.dateFromString(date)
//    }()
    
    
    let rocketName: String
    let flightNo: String
    let flightDate: String
    var launchSite: String = ""
    let launchImage: String

    init(listCellModel: ListCellModelProtocol) {
        self.listCellModel = listCellModel
        
        self.rocketName = self.listCellModel.rocket_name
        self.flightNo = String(self.listCellModel.flight_number)
        // This is a hack, with more time I would have implemented the date formatter
        self.flightDate = String(listCellModel.launch_date_utc.prefix(10))
        self.launchSite = ListCellViewModel.getLaunchSite(site: self.listCellModel.site_name_long)
        self.launchImage = self.listCellModel.imageLink
        
    }
    
    static func getLaunchSite(site: String) -> String {
        // This is a bit of a hack, given more time I would probaly use an enum here
        var launchSite: String = ""
        switch site {
        case "Vandenberg Air Force Base Space Launch Complex 4E":
            launchSite = "Vandenberg Air Force Base"
        case "Cape Canaveral Air Force Station Space Launch Complex 40":
            launchSite = "Cape Canaveral"
        case "Kennedy Space Center Historic Launch Complex 39A":
            launchSite = "Kennedy Space Center"
        case "Kwajalein Atoll Omelek Island":
            launchSite = "Kwajalein Atoll"
        default:
            if let firstWord = site.components(separatedBy: " ").first {
                launchSite = firstWord
            } else {
                launchSite = ""
            }
        }
        return launchSite
    }
    

    
}
