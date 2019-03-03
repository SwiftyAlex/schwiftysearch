//
//  FavouriteCharacter.swift
//  Schwifty Search
//
//  Created by Alex Logan on 03/03/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData

class FavouriteCharacter: NSManagedObject {
    @NSManaged var id: Int16
    @NSManaged var character: Character
}
