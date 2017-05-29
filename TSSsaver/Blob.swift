//
//  Blob.swift
//  TSSsaver
//
//  Created by Jamie Bishop on 21/05/2017.
//  Copyright © 2017 Dynastic Development. All rights reserved.
//

import Foundation

struct Blob {
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    var blobURL: URL {
        return URL(string: self.url)!
    }
}
