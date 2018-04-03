//
//  DetailViewController.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit

protocol DetailCoordinatorProtocol: class {
    
}

class DetailViewController: UIViewController {
    
    // Delegates
    weak var delegateToCoordinator: DetailCoordinatorProtocol?
    
    var viewModel: DetailViewModelInterface!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadView(animated: Bool) {
        
    }
    
}
