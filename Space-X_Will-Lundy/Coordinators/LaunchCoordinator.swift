//
//  LaunchCoordinator.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit

class LaunchCoordinator: Coordinator {
    
    //
    private let presenter: UINavigationController
    
    // View Controllers
    private var searchViewController: SearchViewController?
    private var listViewController: ListViewController?
    private var detailViewController: DetailViewController?
    
    var allLaunches: SpaceXLaunches = SpaceXLaunches()
    let manager = APIManager()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        print("Starting Launch Coordinator")
        let searchVC = Configurator.configureSearchModuleXIB(presenter: self, searchModel: allLaunches)
        self.presenter.pushViewController(searchVC, animated: false)
        self.searchViewController = searchVC
        // given more time I would pre load all the images
    }
    
    func loadLaunches() {
        print("Loading Launches")
        manager.getLaunchStorage(launchSearch: LaunchSearchAPI.AllLaunches.rawValue) { (launches, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let validLaunches = launches else {
                // Both returned as nil, show service unavailable message  I did not have time to implement this
                return
            }
            self.allLaunches = validLaunches
            //print("Launches Recorded: \(self.allLaunches.launches.count)")
        }
    }
}

extension LaunchCoordinator: SearchCoordinatorProtocol {
    
    func searchScreenSearchButtonPressed(year: String, beginDate: String, endDate: String) {
        var searchURL: String = ""
        if year.isEmpty == false {
            searchURL = "https://api.spacexdata.com/v2/launches?launch_year=" + year
        } else if beginDate.isEmpty == false && endDate.isEmpty == false {
            searchURL = "https://api.spacexdata.com/v2/launches?start="+beginDate+"&final="+endDate
        } else {
            searchURL = LaunchSearchAPI.AllLaunches.rawValue
        }
        
        manager.getLaunchStorage(launchSearch: searchURL) { (launches, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    // If we have errors
                    Utilities.showAlert(presenter: self.searchViewController!, title: Constants.LaunchCoordinator.serviceUnavailable)
                    print(error!)
                    return
                }
                //
                guard let validLaunches = launches else {
                    // If we have no launches
                    Utilities.showAlert(presenter: self.searchViewController!, title: Constants.LaunchCoordinator.serviceUnavailable)
                    return
                }
                self.allLaunches = validLaunches
                let listVC = Configurator.configureListModuleXIB(presenter: self, listModel: self.allLaunches)
                self.presenter.pushViewController(listVC, animated: true)
                self.listViewController = listVC
            }
        }
    }
}


extension LaunchCoordinator: ListCoordinatorProtocol {
    func launchListDidSelect(_ selectedLaunch: Launch) {
        let detailVC = Configurator.configureDetailModuleXIB(presenter: self, detailModel: selectedLaunch)
        self.presenter.pushViewController(detailVC, animated: true)
        self.detailViewController = detailVC
    }
}

extension LaunchCoordinator: DetailCoordinatorProtocol {
    
}
