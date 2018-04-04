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
    private var launchSearchViewController: SearchViewController?
    private var launchListViewController: ListViewController?
    private var launchDetailViewController: DetailViewController?
    
    var allLaunches: SpaceXLaunches = SpaceXLaunches()
    let manager = APIManager()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        print("Starting Launch Coordinator")
        let searchVC = Configurator.configureSearchModuleXIB(presenter: self, searchModel: allLaunches)
        self.presenter.pushViewController(searchVC, animated: false)
        self.launchSearchViewController = searchVC
        self.loadLaunches()
        
    }
    
    func loadLaunches() {
        print("Loading Launches")
        manager.getLaunchStorage(launchSearch: .AllLaunches) { (launches, error) in
            
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
    
    func searchScreenSearchButtonPressed() {
        let listVC = Configurator.configureListModuleXIB(presenter: self, listModel: allLaunches)
        presenter.pushViewController(listVC, animated: true)
        
    }
}

extension LaunchCoordinator: ListCoordinatorProtocol {
    func launchListDidSelect(_ selectedLaunch: Launch) {
        
    }
}

extension LaunchCoordinator: DetailCoordinatorProtocol {
    
}
