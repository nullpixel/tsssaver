//
//  UIView+pinToSuperview.swift
//
//  Created by nullpixel on 19/08/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import UIKit

extension UIView {
    /// Pins this view to it's superview
    func pinToSuperview() {
        guard let superview = superview else { fatalError("UIView+pinToSuperview: \(description) has no superview.") }
        pin(to: superview)
    }
    
    /// Pins this view to another view
    /// Note: this sets `translatesAutoresizingMaskIntoConstraints` to false
    func pin(to view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
