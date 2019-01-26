//
//  CodingUserInfoKey.swift
//  Schwifty Search
//
//  Created by Alex Logan on 26/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
