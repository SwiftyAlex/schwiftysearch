//
//  Decoder.swift
//  Schwifty Search
//
//  Created by Alex Logan on 05/02/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Decoder {
    var context : NSManagedObjectContext {
        guard let delegate = (UIApplication.shared.delegate as? AppDelegate) else {
            fatalError("uh, Grandpa rick, there's uh, no context")
        }
        return delegate.persistentContainer.viewContext
    }
}
