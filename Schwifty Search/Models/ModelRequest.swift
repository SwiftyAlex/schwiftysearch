//
//  ModelRequest.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation

struct ModelRequest<Model: Codable> : Codable {
    var results: [Model]?
    var info: RequestInfo?
}

struct RequestInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
