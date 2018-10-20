//
//  BlobSaver.swift
//  TSSsaver
//
//  Created by nullpixel on 21/05/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

import Foundation

class BlobSaver {
    func save(for device: Device, handler: @escaping (BlobResponse?) -> Void) {
        API.shared.makeRequest(to: "app.php", method: .POST([
            "ecid": device.ecid!,
            "boardConfig": device.boardConfig,
            "deviceID": device.model
        ], .formURLEncoded)) { response, error in
            guard let response = response else {
                return handler(nil)
            }
            return handler(BlobResponse.decode(from: response))
        }
    }
    
}
