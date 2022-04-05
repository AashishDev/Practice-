//
//  CoreDataProvider.swift
//  iOSAssignment
//
//  Created by Aashish Tyagi on 4/5/22.
//

import Foundation
import CoreData

class CoreDataProvider {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataProvider()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "iOSAssignmentModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
