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
        permission?.setValue(Constants.camera, forKey: Constants.entityPermissionTitle)
        permission = createPermission()
        permission?.setValue(Int16(PermissionState.todo.rawValue), forKey: Constants.entityPermissionState)
        permission?.setValue(Constants.location, forKey: Constants.entityPermissionTitle)
        permission = createPermission()
        permission?.setValue(Int16(PermissionState.todo.rawValue), forKey: Constants.entityPermissionState)
        permission?.setValue(Constants.photosLibrary, forKey: Constants.entityPermissionTitle)
        
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
