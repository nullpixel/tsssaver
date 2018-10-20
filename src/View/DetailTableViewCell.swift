//
//  DetailTableViewCell.swift
//  TSSSaver
//
//  Created by nullpixel on 19/09/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    convenience init(title: String, value: String) {
        self.init(style: .value1, reuseIdentifier: nil)
        
        textLabel?.text = title
        
        detailTextLabel?.text = value
    }
}
