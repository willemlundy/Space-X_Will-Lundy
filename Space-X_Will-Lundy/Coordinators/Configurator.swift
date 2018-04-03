//
//  Configurator.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit

class Configurator {
    
    class func configureSearchModuleXIB(presenter: SearchCoordinatorProtocol, searchModel: SearchModelProtocol) -> SearchViewController {
        let searchVC = SearchViewController()
        searchVC.delegateToCoordinator = presenter
        searchVC.viewModel = SearchViewModel(searchModel: searchModel)
        searchVC.viewModel.delegateToVC = searchVC
        return searchVC
    }
    
    class func configureListModuleXIB(presenter: ListCoordinatorProtocol, listModel: ListModelProtocol) -> ListViewController {
        let listVC = ListViewController()
        listVC.delegateToCoordinator = presenter
        listVC.viewModel = ListViewModel(listModel: listModel)
        listVC.viewModel.delegateToVC = listVC
        return listVC
    }
    
    class func configureDetailModuleXIB(presenter: DetailCoordinatorProtocol, detailModel: DetailModelProtocol) -> DetailViewController {
        let detailVC = DetailViewController()
        detailVC.delegateToCoordinator = presenter
        detailVC.viewModel = DetailViewModel(detailModel: detailModel)
        detailVC.viewModel.delegateToVC = detailVC
        return detailVC
    }
    
    
}
