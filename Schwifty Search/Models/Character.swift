//
//  Character.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation

struct Character : Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String?
    var gender: String
    var location: Location?
    var origin: Location?
    var image: String?
    var url: String?
    var episode: [String]?
}
