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
    
    
    
    func selectPermissions() -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityPermission)
            
        do {
            let permissionList: [NSManagedObject]? = try managedObjectContext?.fetch(fetchRequest) as? [NSManagedObject]
            return permissionList

        } catch {
            print("CoreData error: selectPermissions")
            return []
        }
    }
    
    func dataMigration() {
        /// Simulated data for a cool data representation
        var permission = createPermission()
        permission?.setValue(Int16(PermissionState.todo.rawValue), forKey: Constants.entityPermissionState)
        permission?.setValue("Camara", forKey: Constants.entityPermissionTitle)
        permission = createPermission()
        permission?.setValue(Int16(PermissionState.todo.rawValue), forKey: Constants.entityPermissionState)
        permission?.setValue("Localizacion", forKey: Constants.entityPermissionTitle)
        permission = createPermission()
        permission?.setValue(Int16(PermissionState.todo.rawValue), forKey: Constants.entityPermissionState)
        permission?.setValue("Otro", forKey: Constants.entityPermissionTitle)
        permission = createPermission()
        permission?.setValue(Int16(PermissionState.todo.rawValue), forKey: Constants.entityPermissionState)
        permission?.setValue("OtroMas", forKey: Constants.entityPermissionTitle)
        
        persistData()
    }
    
    
    // MARK: Private Functions
    
    fileprivate func createPermission() -> NSManagedObject? {
        guard let context = managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: Constants.entityPermission, in: context) else {
                return nil
        }
        return Permission(entity: entity, insertInto: context)
    }
    
    fileprivate func persistData() {
        do {
            try managedObjectContext?.save()
            
        } catch {
            print("CoreData error: persistData")
        }
    }
}
