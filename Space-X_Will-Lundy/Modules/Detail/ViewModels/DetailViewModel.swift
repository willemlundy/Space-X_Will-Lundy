//
//  DetailViewModel.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation

protocol DetailModelProtocol {
    var rocket_name: String { get }
    var flight_number: Int { get }
    var launch_year: String { get }
    var launch_date_local: String { get }
    var launch_date_utc: String { get }
    var details: String { get }
    var site_name_long: String { get }
    var imageLink: String { get }
}

protocol DetailViewModelDelegate: class {
    func reloadView(animated: Bool)
}

protocol DetailViewModelInterface {
    weak var delegateToVC: DetailViewModelDelegate? { get set }
    
    var rocketName: String { get }
    var flightNo: String { get }
    var flightDate: String { get }
    var launchSite: String { get }
    var launchImage: String { get }
    var details: String { get }
}

class DetailViewModel: DetailViewModelInterface {
    
    weak var delegateToVC: DetailViewModelDelegate?
    let detailModel: DetailModelProtocol
    
    let rocketName: String
    let flightNo: String
    let flightDate: String
    var launchSite: String = ""
    let launchImage: String
    let details: String
    
    init(detailModel: DetailModelProtocol) {
        self.detailModel = detailModel
        
        self.rocketName = "Name: " + self.detailModel.rocket_name
        self.flightNo = "Flight No: " + String(self.detailModel.flight_number)
        // This is a hack, with more time I would have implemented the date formatter
        self.flightDate = String(detailModel.launch_date_utc.prefix(10))
        self.launchSite = self.detailModel.site_name_long
        self.launchImage = self.detailModel.imageLink
        self.details = self.detailModel.details
    }
}
