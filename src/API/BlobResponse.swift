//
//  BlobResponse.swift
//  TSSSaver
//
//  Created by nullpixel on 20/09/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import Foundation

struct BlobResponse: TSSResponse {
    let success: Bool
    let url: URL?

    let error: SaverError?
    
    struct SaverError: Decodable {
        let code: Int
        let message: String
    }
}
