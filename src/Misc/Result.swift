//
//  Result.swift
//  TSSSaver
//
//  Created by nullpixel on 20/09/2018.
//  Copyright © 2018 Dynastic Development. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error?)
}
