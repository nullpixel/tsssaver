//
//  UIViewController+showAlert.swift
//  TSSSaver
//
//  Created by nullpixel on 20/10/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil, handler: (() -> Void)? = nil) {
        showAlert(title: title, message: message, with: [
            UIAlertAction(title: "OK", style: .cancel) { _ in
                handler?()
            }
        ])
    }
    
    func showAlert(title: String? = nil, message: String? = nil, with actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        
        present(alert, animated: true, completion: nil)
    }
}
