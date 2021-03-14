//
//  CoreDataProvider.swift
//  atSistemasApp
//
//  Created by APPLE on 13/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit
import CoreData

class CoreDataProvider: CoreDataProviderContract {
    /// Persistent Containter object from AppDelegate
    private var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    
    // MARK: Public Functions
    
    func saveFavourite(id: Int) {
        guard let context = managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: Constants.entityFavouriteChars, in: context) else {
            return
        }
        
        /// NSManagedObject with element's values
        let favouriteCharObject = NSManagedObject(entity: entity, insertInto: context)
        favouriteCharObject.setValue(id, forKey: Constants.entityFavouriteCharsId)
        
        do {
            try context.save()
            
        } catch {
            print("Error saving char \(id)")
        }
    }
    
    func deleteFavourite(id: Int) {
        guard let context = managedObjectContext else {
            return
        }

        /// Query / Where conditions objects
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityFavouriteChars)
        let fetchPredicate: NSPredicate = NSPredicate(format: "\(Constants.entityFavouriteCharsId) = %i", id)
        fetchRequest.predicate = fetchPredicate
        
        /// .delete needs a NSManagedObject
        guard let char = try? context.fetch(fetchRequest) as? [NSManagedObject] else { return }
        char.forEach { context.delete($0) }
        
        do {
            try context.save()
                
        } catch {
            print("Error deleting char \(id)")
        }
    }
    
    func isFavourite(id: Int32) -> Bool {
        guard let context = managedObjectContext else {
            return false
        }
    
        /// Query / Where conditions objects
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityFavouriteChars)
        let fetchPredicate = NSPredicate(format: "\(Constants.entityFavouriteCharsId) = %i", id)
        fetchRequest.predicate = fetchPredicate
        
        ///BORRADO TOTAL TEMPORAL
        /* guard let char = try? context.fetch(fetchRequest) as? [NSManagedObject] else { return false }
        char.forEach { context.delete($0) }
        try! context.save() */
        ///BORRADO TOTAL TEMPORAL
        
        /// Fetch char if exits
        do {
            let chars = try context.fetch(fetchRequest)
            return !chars.isEmpty
            
        } catch {
            print("Error al cargar de CoreData")
            return false
        }
    }
}
