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
        
        guard Device.current.ecid != nil else {
            return showAlert(title: "Could not find ECID", message: "We could not find your device ECID. Please ensure that you are running on a jailbroken device.", with: [])
        }
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
            case 0: return DetailTableViewCell(title: "ECID", value: Device.current.ecid ?? "Unknown")
            case 1: return DetailTableViewCell(title: "Board Configuration", value: Device.current.boardConfig)
            case 2: return DetailTableViewCell(title: "Model", value: Device.current.model)
            default: fatalError("Row out of range.")
            }
        }

        return ActionTableViewCell(title: "Save Blobs")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // FIXME: - Clean this up
        if indexPath.section == 1 {
            let cell = tableView.cellForRow(at: indexPath) as! ActionTableViewCell
            cell.isAnimating = true

            BlobSaver().save(for: Device.current) { result in
                DispatchQueue.main.async { cell.isAnimating = false }

                switch result {
                case .success(let blob):
                    let actions = [
                        UIAlertAction(title: "Open", style: .default) { _ in
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(blob.url)
                            } else {
                                UIApplication.shared.openURL(blob.url)
                            }
                        },
                        UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                    ]
                    
                    return self.showAlert(title: "Saved Blobs", message: "Your blobs were successfully saved.", with: actions)
                case .failure(let error):
                    return self.showAlert(title: "An Error Occured", message: error.errorDescription)
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension DeviceInfoViewController {
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // Only show taps on the button cell
        return indexPath.section == 1
    }
    
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
