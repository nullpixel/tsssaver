//
//  BlobSaver.swift
//  TSSsaver
//
//  Created by nullpixel on 21/05/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

import Foundation

class BlobSaver {
    func save(for device: Device, handler: @escaping (Result<Blob>) -> Void) {
        API.shared.makeRequest(to: "app.php", method: .POST([
            "ecid": device.ecid!,
            "boardConfig": device.boardConfig,
            "deviceID": device.model
        ], .formURLEncoded)) { response, error in
            guard let response = response,
                let decoded = BlobResponse.decode(from: response) else {
                return handler(.failure(.unknownError))
            }
            if let error = decoded.error { return handler(.failure(.saverError(error))) }
            guard let url = decoded.url else { return handler(.failure(.unknownError)) }
            
            return handler(.success(Blob(url: url)))
        }
    }
    
}
