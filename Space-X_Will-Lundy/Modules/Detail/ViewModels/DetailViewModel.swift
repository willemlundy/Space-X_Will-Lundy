//
//  DetailViewModel.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation

protocol DetailModelProtocol {
    
}

protocol DetailViewModelDelegate: class {
    func reloadView(animated: Bool)
}

protocol DetailViewModelInterface {
    
    weak var delegateToVC: DetailViewModelDelegate? { get set }
    
}


class DetailViewModel: DetailViewModelInterface {
    
    weak var delegateToVC: DetailViewModelDelegate?
    
    let detailModel: DetailModelProtocol
    
    
    
    init(detailModel: DetailModelProtocol) {
        self.detailModel = detailModel
    }
    
    
    
}
