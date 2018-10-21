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
    case failure(AppError)
    
    enum AppError: Error, LocalizedError {
        case unknownError
        case saverError(BlobResponse.SaverError)
        
        var errorDescription: String? {
            switch self {
            case .unknownError: return "An unknown error occured, please ensure you are connected to the internet and try again."
            case .saverError(let error): return "\(error.message) (code: \(error.code))."
            }
        }
    }
}
