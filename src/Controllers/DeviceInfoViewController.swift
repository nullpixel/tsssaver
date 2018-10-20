//
//  DeviceInfoViewController.swift
//  TSSSaver
//
//  Created by nullpixel on 18/09/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import UIKit

class DeviceInfoViewController: UITableViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TSS Saver"
    }
}

// MARK: - UITableViewDataSource
extension DeviceInfoViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 1: return 1
        default: fatalError("Unknown section.")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // FIXME: - Terrible, terrible code
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: return DetailTableViewCell(title: "ECID", value: Device.current.ecid ?? "unknown")
            case 1: return DetailTableViewCell(title: "Board Configuration", value: Device.current.boardConfig)
            case 2: return DetailTableViewCell(title: "Model", value: Device.current.model)
            default: fatalError("Row out of range.")
            }
        }

        return ActionTableViewCell(title: "Save Blobs")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // FIXME: - Clean this up
        // TODO: - Add activity indicator
        if indexPath.section == 1 {
            BlobSaver().save(for: Device.current) { blob in
                if let error = blob?.error {
                    return self.showAlert(title: "An Error Occured", message: error.message)
                }
                
                if let url = blob?.url {
                    let alert = UIAlertController(title: "Saved Blobs", message: "Your blobs were successfully saved.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Open", style: .default) { _ in
                        if #available(iOS 10.0, *) {
                            return UIApplication.shared.open(url)
                        }
                        return UIApplication.shared.openURL(url)
                    })
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension DeviceInfoViewController {
    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }
    
    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        guard action == #selector(UIResponderStandardEditActions.copy) else {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        UIPasteboard.general.string = cell?.detailTextLabel?.text
    }
}

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            handler?()
        })
        present(alert, animated: true, completion: nil)
    }
}
