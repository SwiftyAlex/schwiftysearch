//
//  Episode.swift
//  Schwifty Search
//
//  Created by Alex Logan on 05/02/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Episode : NSManagedObject, NSManagedCodable {
    @NSManaged var id: Int16
    @NSManaged var name: String
    @NSManaged var airDate: String
    @NSManaged var episode: String
    @NSManaged var url: String
    @NSManaged var created: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created, airDate
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(entity: Episode.entity(), insertInto: Episode.context)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.airDate = try container.decode(String.self, forKey: .airDate)
        self.episode = try container.decode(String.self, forKey:  .episode)
        self.created = try container.decode(Date.self, forKey: .created)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
    

}
