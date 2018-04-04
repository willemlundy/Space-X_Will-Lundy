//
//  SearchViewModel.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation

protocol SearchModelProtocol {

}

protocol SearchViewModelDelegate: class {
    // Given more time I would have stored more state in the VM and reloaded the VC through this delegate
    func reloadView(animated: Bool)
}

protocol SearchViewModelInterface {
    
    weak var delegateToVC: SearchViewModelDelegate? { get set }
    func isValidDate(date: String) -> Bool
    func isValidYear(str: String) -> Bool
    func isLaunchYear(str: String) -> Bool
}

class SearchViewModel: SearchViewModelInterface {
    
    weak var delegateToVC: SearchViewModelDelegate?
    let searchModel: SearchModelProtocol
    
    init(searchModel: SearchModelProtocol) {
        self.searchModel = searchModel
        
    }
    
    func isValidDate(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard dateFormatter.date(from: date) != nil else {
            return false
        }
        return true
    }
    
    func isValidYear(str: String) -> Bool {
        guard let year = Int(str),
            year <= 9999,
            year >= 1000 else { return false }
        return true
    }
    
    func isLaunchYear(str: String) -> Bool {
        guard let year = Int(str),
            year != 2011,
            year >= Constants.Search.firstSpaceLaunch,
            year <= Constants.Search.furthestSpaceLaunch else { return false }
        return true
    }
}
