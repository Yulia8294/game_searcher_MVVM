//
//  AppDelegate.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appDIContainer = AppDIContainer()
    var mainCordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        performRealmMigration()
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()
        window?.rootViewController = nav
        mainCordinator = MainCoordinator(navigationController: nav, appDIContainer: appDIContainer)
        
        mainCordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func performRealmMigration() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }

}

