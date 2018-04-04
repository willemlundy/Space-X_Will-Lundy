//
//  ListViewController.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/2/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit
import Kingfisher

protocol ListCoordinatorProtocol: class {
    func launchListDidSelect(_ selectedLaunch: Launch)
}

class ListViewController: UIViewController {
    
    // Delegates
    weak var delegateToCoordinator: ListCoordinatorProtocol?
    // View Models
    var viewModel: ListViewModelInterface!
    
    @IBOutlet weak var listTableView: UITableView!
    
    public required init() {
        super.init(nibName: Constants.List.nibName, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var List: [Launch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: Constants.List.ListCell.nibName, bundle: Bundle.main)
        listTableView.register(nib, forCellReuseIdentifier: Constants.List.ListCell.reuseID)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableViewCell
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: Constants.List.ListCell.reuseID) as? ListTableViewCell {
            cell = dequeueCell
        } else {
            cell = ListTableViewCell(style: .subtitle, reuseIdentifier: Constants.List.ListCell.reuseID)
        }
        let launch = viewModel.listModel.launches[indexPath.row]
        let cellViewModel: ListCellViewModelInterface = ListCellViewModel(listCellModel: launch)
        cell.rocketName.text = cellViewModel.rocketName
        cell.flightNo.text = cellViewModel.flightNo
        cell.flightDate.text = cellViewModel.flightDate
        cell.launchSite.text = cellViewModel.launchSite
        if let url = URL(string: launch.imageLink),
            let imageView = cell.launchImage {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, completionHandler: {
                (image, error, cacheType, imageUrl) in
                cell.layoutSubviews()
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = viewModel.listModel.launches[indexPath.row]
        delegateToCoordinator?.launchListDidSelect(launch)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: ListViewModelDelegate {
    func reloadView(animated: Bool) {
        //ListTableView?.reloadData()
    }
}
