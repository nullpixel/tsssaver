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

    static var ecid: String? {
        return get_ecid() as String

        // TOOD: Fix my pure swift rewrite :(
        
        // let service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice").takeUnretainedValue())
        // guard service != 0 else { fatalError("Can't find IOPlatformExpertDevice"); return nil }
        
        // let ecidProp = IORegistryEntrySearchCFProperty(service, kIODeviceTreePlane, "unique-chip-id" as CFString, kCFAllocatorDefault, UInt32(kIORegistryIterateRecursively))
        // guard ecidProp != nil else { fatalError("Can't find unique-chip-id property"); IOObjectRelease(service); return nil }
        // guard let ecidData: CFData = ecidProp?.takeUnretainedValue() else { fatalError("ecid prop is nil"); IOObjectRelease(service); return nil }
        // IOObjectRelease(service)

        // // guard let ecid = ecidData?.takeUnretainedValue() as? String else { fatalError("Cast failed. \(ecidData?.takeUnretainedValue())"); return nil }
        // //guard let bufSize = CFDataGetLength(ecidData) else { return nil } 
        // let ecid = String(bytes: CFDataGetBytePtr(ecidData) as , encoding: .utf8)
        // return ecid 
        // // guard let bytes: UnsafePointer<UInt64> = CFDataGetBytePtr(ecidData as CFData) else { fatalError("getting bytes failed. \(ecidData)"); return nil }
        // // guard let ecid = CFStringCreateWithFormat(kCFAllocatorDefault, nil, "%llu" as CFString, bytes) else { return nil }
        // // return ecid as String
    }
}
