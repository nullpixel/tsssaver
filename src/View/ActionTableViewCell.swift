//
//  ActionTableViewCell.swift
//  TSSSaver
//
//  Created by nullpixel on 20/10/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    var button = UIButton()
    
    convenience init(title: String) {
        self.init(style: .default, reuseIdentifier: nil)
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(tintColor, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    private func setup() {
        button.titleLabel?.textAlignment = .center
        button.isUserInteractionEnabled = false
        
        contentView.addSubview(button)
    }
    
    private func layout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}
