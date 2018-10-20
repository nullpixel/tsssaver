//
//  Device.swift
//  TSSSaver
//
//  Created by nullpixel on 29/05/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

import Foundation

struct Device {
    let model: String
    let boardConfig: String
    let ecid: String?
    
    /// Represents the current device.
    static var current: Device {
        return Device(model: Sysctl.model,
                      boardConfig: Sysctl.machine,
                      ecid: getECID() as String?)
    }
}
