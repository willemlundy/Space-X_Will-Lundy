//
//  Utilities.swift
//  Space-X_Will-Lundy
//
//  Created by William Lundy on 4/4/18.
//  Copyright © 2018 William Lundy. All rights reserved.
//

import UIKit

class Utilities {
    // Shows a alert view with a message and an OK button
    class func showAlert(presenter: UIViewController, title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    
}
