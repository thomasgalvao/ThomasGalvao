//
//  AppDelegate.swift
//  ThomasGalvao
//
//  Created by Thomas Galvão on 18/04/2018.
//  Copyright © 2018 Thomas Galvao. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "ThomasGalvao")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        })
        return container
    }()
    
}

