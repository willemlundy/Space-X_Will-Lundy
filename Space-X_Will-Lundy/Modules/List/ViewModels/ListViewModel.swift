//
//  ListViewModel.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import Foundation

protocol ListModelProtocol {
    var launches: [Launch] { get }
}

protocol ListViewModelDelegate: class {
    func reloadView(animated: Bool)
}

protocol ListViewModelInterface {
    
    weak var delegateToVC: ListViewModelDelegate? { get set }
    var listModel: ListModelProtocol { get }
    var numberOfItems: Int { get }
}


class ListViewModel: ListViewModelInterface {
    
    weak var delegateToVC: ListViewModelDelegate?
    
    let listModel: ListModelProtocol
    
    var numberOfItems: Int {
        return listModel.launches.count
    }
    
    
    init(listModel: ListModelProtocol) {
        self.listModel = listModel
        // self.numberOfItems =
    }
    
    
    
}
