//
//  BaseCoreDataModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 25.08.22.
//

import Foundation
import CoreData

protocol BaseCoreDataModel where Self: NSManagedObject {
    func save()
    func delete()
    static func allObjects<T: NSManagedObject>() -> [T]
    static func modelWith<T: NSManagedObject>(id: NSManagedObjectID) -> T?
}

extension BaseCoreDataModel {
    static var viewContext: NSManagedObjectContext {
        return CoreDataStack.shared.viewContext
    }
    
    func save() {
        do {
            try Self.viewContext.save()
        } catch {
            Self.viewContext.rollback()
            print("Failed to save model with error \(error)")
        }
    }
    
    func delete() {
        Self.viewContext.delete(self)
        save()
    }
    
    static func allObjects<T>() -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func modelWith<T>(id: NSManagedObjectID) -> T? {
        do {
            return try viewContext.existingObject(with: id) as? T
        } catch {
            print("Failed to fetch model by id with error \(error)")
            return nil
        }
    }
}
