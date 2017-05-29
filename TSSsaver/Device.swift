//
//  Device.swift
//  TSSSaver
//
//  Created by Jamie Bishop on 29/05/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

import Foundation

struct Device {
    let model = Sysctl.model
    let boardConfig = Sysctl.machine
    
    #if DEBUG
        let ecid = "4907733951592" as? String // Needs to be optional to shut the compiler up
    #else
        let ecid = get_ecid() as? String
    #endif
}
