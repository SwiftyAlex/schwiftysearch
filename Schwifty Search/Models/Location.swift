//
//  Location.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedCodable {
    @NSManaged var name: String
    @NSManaged var url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedObjectContext) else {
                fatalError("Failed to decode Location")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .name)
    }
}
