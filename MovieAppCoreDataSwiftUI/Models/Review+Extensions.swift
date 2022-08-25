//
//  Review+Extensions.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 25.08.22.
//

import Foundation
import CoreData

extension Review: BaseCoreDataModel {}

extension Review {
    static func getReviewsFor(movieId: NSManagedObjectID) -> [Review] {
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.predicate = NSPredicate(format: "movie == %@", movieId)
        
        do {
            return try CoreDataStack.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
