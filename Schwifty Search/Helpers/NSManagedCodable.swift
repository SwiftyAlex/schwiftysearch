//
//  NSManagedCodable.swift
//  Schwifty Search
//
//  Created by Alex Logan on 27/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol NSManagedCodable: Codable {
    var id: Int16 { get set }
}

struct Context {
    static var context : NSManagedObjectContext {
        guard let delegate = (UIApplication.shared.delegate as? AppDelegate) else {
            fatalError("uh, Grandpa rick, there's uh, no context")
        }
        return delegate.persistentContainer.viewContext
    }
}

extension NSManagedCodable where Self: NSManagedObject {
    static var context : NSManagedObjectContext {
        guard let delegate = (UIApplication.shared.delegate as? AppDelegate) else {
            fatalError("uh, Grandpa rick, there's uh, no context")
        }
        return delegate.persistentContainer.viewContext
    }
    
    static func storedObjects() -> [Self] {
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let results = try! Self.context.fetch(fetchRequest)
        return results
    }
}


extension NSManagedCodable where Self: NSManagedObject {
    internal static var entity: NSEntityDescription { return entity()  }
    
    internal static var entityName: String { return entity.name!  }
    
    static func findOrCreate(in context: NSManagedObjectContext = context, id: Int16) -> Self {
        let predicate = NSPredicate(format: "id = %d", id)
        let fetchRequest = NSFetchRequest<Self>(entityName: Self.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = predicate
        let results = try! context.fetch(fetchRequest)
        guard let object = results.first else {
            return self.init(entity: Self.entity(), insertInto: context)
        }
        return object
    }
    
}
