//
//  ProgressHUD.swift
//  TSSSaver
//
//  Created by nullpixel on 29/05/2017.
//  
//  Taken from https://stackoverflow.com/questions/28785715/how-to-display-an-activity-indicator-with-text-on-ios-8-with-swift
//

import UIKit

class ActivityIndicatorView {
    var view: UIView
    var activityIndicator: UIActivityIndicatorView
    
    init(title: String, center: CGPoint, width: CGFloat = 200.0, height: CGFloat = 50.0) {
        let x = center.x - width/2.0
        let y = center.y - height/2.0
        
        view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 51.0/255.0, alpha: 0.5)
        view.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.color = UIColor.black
        activityIndicator.hidesWhenStopped = false
        
        let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        titleLabel.text = title
        titleLabel.textColor = UIColor.black
        
        view.addSubview(activityIndicator)
        view.addSubview(titleLabel)
    }
    
    func startAnimating() {
        OperationQueue.main.addOperation {
            self.activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func stopAnimating() {
        OperationQueue.main.addOperation {
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            self.view.removeFromSuperview()
        }
    }
}
