//
//  Character.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData

typealias NSManagedCodable = NSManagedObject & Codable
class Character : NSManagedCodable {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var status: String
    @NSManaged var species: String
    @NSManaged var type: String?
    @NSManaged var gender: String
    @NSManaged var location: Location?
    @NSManaged var origin: Location?
    @NSManaged var image: String?
    @NSManaged var url: String?
    @NSManaged var episode: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id,name,status,species,type,gender,location,origin,image,url,episode
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Character", in: managedObjectContext) else {
                fatalError("Failed to decode Character")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.url = try container.decode(String.self, forKey: .url)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
