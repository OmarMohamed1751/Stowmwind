//
//  Extentions.swift
//  Stormwind
//
//  Created by Omar on 11/5/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

extension UIViewController {
    // Alert
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
}
