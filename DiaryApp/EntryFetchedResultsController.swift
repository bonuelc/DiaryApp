//
//  EntryFetchedResultsController.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/8/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import CoreData

class EntryFetchedResultsController: NSFetchedResultsController {
    
    init(fetchRequest: NSFetchRequest, managedObjectContext: NSManagedObjectContext) {
        
        super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetch()
    }
    
    func fetch() {
        
        do {
            try performFetch()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
