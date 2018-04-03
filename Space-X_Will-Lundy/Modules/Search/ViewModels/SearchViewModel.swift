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
    func reloadView(animated: Bool)
}

protocol SearchViewModelInterface {
    
    weak var delegateToVC: SearchViewModelDelegate? { get set }
    
}


class SearchViewModel: SearchViewModelInterface {
    
    weak var delegateToVC: SearchViewModelDelegate?
    
    let searchModel: SearchModelProtocol
    
    
    
    init(searchModel: SearchModelProtocol) {
        self.searchModel = searchModel
        
    }
    
    
    
}
