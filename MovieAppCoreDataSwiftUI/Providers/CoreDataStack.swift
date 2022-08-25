//
//  CoreDataStack.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 23.08.22.
//

import Foundation
import CoreData

final class CoreDataStack {
    let persistentContainer: NSPersistentContainer
    
    static let shared: CoreDataStack = CoreDataStack()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieModel")
        loadPersistentStores()
    }
}

// MARK: - Public
extension CoreDataStack {
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

// MARK: - Private
private extension CoreDataStack {
    func loadPersistentStores() {
        persistentContainer.loadPersistentStores { decsription, error in
            if let error = error {
                fatalError("Failed to initialized CoreData with error \(error)")
            }
        }
    }
}
