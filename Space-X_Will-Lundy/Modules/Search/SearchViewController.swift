//
//  SearchViewController.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit

protocol SearchCoordinatorProtocol: class {
    func searchScreenSearchButtonPressed(year: String, beginDate: String, endDate: String)
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
        searchYearTextField.delegate = self
        beginDateTextField.delegate = self
        endDateTextField.delegate = self
        self.configureAllViews()
        let answer = isValidDate(str: "2017-13-21")
        print("Answer: \(answer)")
    }
    
    func configureAllViews() {
        self.setupNavBar()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func clearTextFields() {
        self.searchYearTextField.text = ""
        self.beginDateTextField.text = ""
        self.endDateTextField.text = ""
    }
    
    func setupNavBar() {
        self.title = "Launch Search"
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        guard let year = self.searchYearTextField.text,
            let beginDate = self.beginDateTextField.text,
            let endDate = self.endDateTextField.text else {
                return
        }
        
        guard year.count == 4 || (beginDate  != "" && endDate != "")  else {
            let alert = UIAlertController(title: "Make sure you enter a four digit year or start and end dates", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // TODO: check for good values
        
        self.view.endEditing(true)
        delegateToCoordinator?.searchScreenSearchButtonPressed(year: year, beginDate: beginDate, endDate: endDate)
        
    }
    
    func isValidDate(str: String) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard dateFormatter.date(from: str) != nil else {
            return false
        }
        
        return true
        
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed.
    {
        return true
    }
    
    
}

extension SearchViewController: SearchViewModelDelegate {
    func reloadView(animated: Bool) {
        
    }
    
}
