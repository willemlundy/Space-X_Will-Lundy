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
    
    var viewModel: ListViewModelInterface!
    
    @IBOutlet weak var listTableView: UITableView!
    
    public required init() {
        super.init(nibName: "List", bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var List: [Launch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ListTableViewCell", bundle: Bundle.main)
        listTableView.register(nib, forCellReuseIdentifier: "LaunchItem")
        //        ListTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableViewCell
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "LaunchItem") as? ListTableViewCell {
            cell = dequeueCell
        } else {
            cell = ListTableViewCell(style: .subtitle, reuseIdentifier: "LaunchItem")
        }
        let launch = viewModel.listModel.launches[indexPath.row]
        cell.rocketName.text = launch.rocket_name
        cell.flightNo.text = String(launch.flight_number)
        cell.flightDate.text = launch.launch_date_local
        cell.launchSite.text = launch.site_name_long
        if var url = URL(string: launch.imageLink),
            let imageView = cell.imageView {
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