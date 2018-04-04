//
//  SearchViewController.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit

protocol SearchCoordinatorProtocol: class {
    func searchScreenSearchButtonPressed()
}

class SearchViewController: UIViewController {
    
    // Delegates
    weak var delegateToCoordinator: SearchCoordinatorProtocol?
    
    var viewModel: SearchViewModelInterface!
    
    @IBOutlet weak var searchYearLabel: UILabel!
    @IBOutlet weak var searchYearTextField: UITextField!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var beginDateTextField: UITextField!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateTextField: UITextField!
    
    public required init() {
        super.init(nibName: "Search", bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAllViews()
    }
    
    func configureAllViews() {
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.title = "Launch Search"
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        delegateToCoordinator?.searchScreenSearchButtonPressed()
    }
    
    
}

extension SearchViewController: SearchViewModelDelegate {
    func reloadView(animated: Bool) {
        
    }
    
}
