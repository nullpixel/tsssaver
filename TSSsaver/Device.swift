//
//  Device.swift
//  TSSSaver
//
//  Created by Jamie Bishop on 29/05/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

import Foundation

struct Device {
    static let model = Sysctl.model
    static let boardConfig = Sysctl.machine
    
    #if DEBUG
    static let ecid = "4907733951592" as? String // Needs to be optional to shut the compiler up
    #else
    static let ecid = get_ecid() as! String
    #endif
}
