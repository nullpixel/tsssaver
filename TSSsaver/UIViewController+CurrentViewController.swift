//
//  UIViewController+CurrentViewController.swift
//
//  Created by AppleBetas on 2017-01-24.
//  Copyright © 2017 AppleBetas. All rights reserved.
//

import UIKit

extension UIViewController {
    var currentViewController: UIViewController {
        get {
            if let presentedViewController = presentedViewController {
                return presentedViewController
            }
            return self
        }
    }
}

extension UINavigationController {
    override var currentViewController: UIViewController {
        get {
            if let viewController = visibleViewController {
                return viewController.currentViewController
            }
            return super.currentViewController
        }
    }
}

extension UITabBarController {
    override var currentViewController: UIViewController {
        get {
            if let viewController = selectedViewController {
                return viewController.currentViewController
            }
            return super.currentViewController
        }
    }
}

extension UISplitViewController {
    override var currentViewController: UIViewController {
        get {
            if let viewController = viewControllers.first {
                return viewController.currentViewController
            }
            return super.currentViewController
        }
    }
}

extension UIWindow {
    var currentViewController: UIViewController? {
        get {
            if let viewController = rootViewController {
                return viewController.currentViewController
            }
            return nil
        }
    }
}

extension UIApplication {
    var currentViewController: UIViewController? {
        get {
            if let window = self.keyWindow {
                return window.currentViewController
            }
            return nil
        }
    }
}
