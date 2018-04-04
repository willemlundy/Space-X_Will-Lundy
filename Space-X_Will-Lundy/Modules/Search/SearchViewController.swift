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
    
    // View Model
    var viewModel: SearchViewModelInterface!
    
    @IBOutlet weak var searchYearLabel: UILabel!
    @IBOutlet weak var searchYearTextField: UITextField!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var beginDateTextField: UITextField!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    public required init() {
        super.init(nibName: Constants.Search.nibName, bundle: nil)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearTextFields()
    }
    
    func configureAllViews() {
        self.setupNavBar()
        setupButton()
    }
    
    func setupNavBar() {
        self.title = Constants.Search.title
    }
    
    func setupButton() {
        searchButton.layer.cornerRadius = 22
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor.orange.cgColor
        searchButton.titleLabel?.textColor = UIColor.orange
    }
    
    func clearTextFields() {
        clearYearField()
        clearDateFields()
    }
    
    func clearYearField() {
        self.searchYearTextField.text = ""
    }
    
    func clearDateFields() {
        self.beginDateTextField.text = ""
        self.endDateTextField.text = ""
    }
    
    @IBAction func yearTextFieldTapped(_ sender: UITextField) {
        clearDateFields()
    }
    
    @IBAction func startTextFieldTapped(_ sender: UITextField) {
        clearYearField()
    }
    
    @IBAction func endTextFieldTapped(_ sender: UITextField) {
        clearYearField()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        guard let year = self.searchYearTextField.text,
            let beginDate = self.beginDateTextField.text,
            let endDate = self.endDateTextField.text else {
                return
        }
        beginSearch(year: year, beginDate: beginDate, endDate: endDate)
    }
    
    func beginSearch(year: String, beginDate: String, endDate: String) {
        // Messaging and checking on the year and dates
        // Given more time I would have made sure all the edge cases were covered
        // Also, I'm not into the empty string comparison, but I dont have time to do more
        guard year.isEmpty == false || (beginDate.isEmpty == false && endDate.isEmpty == false) else {
            Utilities.showAlert(presenter: self, title: Constants.Search.fourDigitYearMessage)
            return
        }
        if beginDate.isEmpty && endDate.isEmpty {
            
            guard viewModel.isValidYear(str: year) else {
                Utilities.showAlert(presenter: self, title: Constants.Search.fourDigitMessage)
                clearTextFields()
                return
            }
            guard viewModel.isLaunchYear(str: year) else {
                let titleMessage = Constants.Search.noLaunchesMessage + year
                Utilities.showAlert(presenter: self, title: titleMessage)
                clearTextFields()
                return
            }
        }
        if year.isEmpty  {
            guard viewModel.isValidDate(date: beginDate),
            viewModel.isValidDate(date: endDate) else {
                Utilities.showAlert(presenter: self, title: Constants.Search.followFormat)
                clearTextFields()
                return
            }
        }
        self.view.endEditing(true)
        delegateToCoordinator?.searchScreenSearchButtonPressed(year: year, beginDate: beginDate, endDate: endDate)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed.
    {
        guard let year = self.searchYearTextField.text,
            let beginDate = self.beginDateTextField.text,
            let endDate = self.endDateTextField.text else {
                return false
        }
        // Close the keyboard and submit the search
        beginSearch(year: year, beginDate: beginDate, endDate: endDate)
        self.view.endEditing(true)
        return true
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func reloadView(animated: Bool) {
    }
}
