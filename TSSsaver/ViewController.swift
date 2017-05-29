//
//  ViewController.swift
//  TSSsaver
//
//  Created by Jamie Bishop on 13/04/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var ecidLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var boardconfLabel: UILabel!
    @IBOutlet weak var blobButton: UIButton!
    
    private var blobSaver = BlobSaver()
    private var activityIndicatorView: ActivityIndicatorView!
    private var device = Device()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        self.view.backgroundColor = UIColor(red: 35.0/255.0, green: 39.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        self.tableView.backgroundColor = UIColor(red: 35.0/255.0, green: 39.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    }
    
    func setup() {
        guard device.ecid != nil else { invalidECID(); return }
        OperationQueue.main.addOperation {
            self.activityIndicatorView = ActivityIndicatorView(title: "Saving Blobs", center: self.view.center)
            
            self.ecidLabel.text = self.device.ecid
            self.modelLabel.text = self.device.model
            self.boardconfLabel.text = self.device.boardConfig
        }
    }
    
    func invalidECID() {
        let alert = UIAlertController(title: "Can't find your ECID", message: "We cannot find your ECID automatically. Please ensure you are in jailbroken mode.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveBlobs() {
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
        
        blobSaver.save(for: self.device.ecid!, board: self.device.boardConfig, model: self.device.model, handler: { (Blob, SaverError) in
            self.activityIndicatorView.stopAnimating()
            if SaverError != nil {
                SaverError!.presentError()
                return
            }
            guard let blob = Blob else { return } // it's fine to not show an error here since it's impossible to get to this stage.
            
            let alert = UIAlertController(title: "Saved blobs!", message: "I saved your blobs! Press open to view them in safari.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Open!", style: .default, handler: { (action) in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(blob.blobURL)
                } else {
                    // fallback to older iOS
                    UIApplication.shared.openURL(blob.blobURL)
                }
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 1 {
            saveBlobs()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        cell.selectedBackgroundView = selectionView
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.white.withAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.white.withAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

