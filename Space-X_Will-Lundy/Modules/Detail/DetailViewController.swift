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
    // View Model
    var viewModel: DetailViewModelInterface!
    // Outlets
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var flightNo: UILabel!
    @IBOutlet weak var flightDate: UILabel!
    @IBOutlet weak var launchSiteLong: UILabel!
    @IBOutlet weak var patchImage: UIImageView!
    @IBOutlet weak var detailsTextView: UITextView!
    
    
    public required init() {
        super.init(nibName: Constants.Detail.nibName, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rocketName.text = viewModel.rocketName
        self.flightNo.text = viewModel.flightNo
        self.flightDate.text = viewModel.flightDate
        self.launchSiteLong.text = viewModel.launchSite
        self.detailsTextView.text = viewModel.details
        if let url = URL(string: viewModel.launchImage),
            let imageView = self.patchImage {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, completionHandler: {
                (image, error, cacheType, imageUrl) in
            })
        }
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadView(animated: Bool) {
    }
}
