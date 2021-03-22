//
//  AppDelegate.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// DB Object Container
    static let appName: String = {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let appName = infoDictionary["APP_NAME"] as? String else {
            return String()
        }
        return appName
    }()
    
    /// DB Object Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.coreDataStorage)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        /// Data Commit when App terminate
        saveDBContext()
    }
}


// MARK: CoreData Saving Support

extension AppDelegate {
    func saveDBContext() {
        let context = persistentContainer.viewContext
        
        /// Check if something for commit
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nsError = error as NSError
                print("Error CoreData: \(nsError.userInfo)")
            }
        }
    }
}
