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
        //self.loadLaunches()
        
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
        guard year.count == 4 || (beginDate  != "" && endDate != "")  else {
            
            let alert = UIAlertController(title: "Make sure you enter a four digit year.", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in }))
            self.searchViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        if year.count == 4 {
            searchURL = "https://api.spacexdata.com/v2/launches?launch_year=" + year
        } else if beginDate  != "" && endDate != "" {
            searchURL = "https://api.spacexdata.com/v2/launches?start="+beginDate+"&final="+endDate
        } else {
            searchURL = LaunchSearchAPI.AllLaunches.rawValue
        }
        
        manager.getLaunchStorage(launchSearch: searchURL) { (launches, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    print(error!)
                    return
                }
                
                guard let validLaunches = launches else {
                    // Both returned as nil, show service unavailable message  I did not have time to implement this
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
        
    }
}

extension LaunchCoordinator: DetailCoordinatorProtocol {
    
}
