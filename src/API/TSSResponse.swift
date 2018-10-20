//
//  TSSResponse.swift
//  TSSSaver
//
//  Created by nullpixel on 20/09/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import Foundation

protocol TSSResponse : Decodable {}

extension TSSResponse {
    static func decode(from data: Data) -> Self? {
        return try? JSONDecoder().decode(self, from: data)
    }
}

