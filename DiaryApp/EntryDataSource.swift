//
//  EntryDataSource.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/8/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EntryDataSource: NSObject, UITableViewDataSource {
    
    let tableView: UITableView
    let fetchedResultsController: EntryFetchedResultsController
    
    init(tableView: UITableView, fetchRequest: NSFetchRequest, managedObjectContext: NSManagedObjectContext) {
        
        self.tableView = tableView
        self.fetchedResultsController = EntryFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, tableView: tableView)
        
        super.init()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        
        return section.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let entry = fetchedResultsController.objectAtIndexPath(indexPath) as! Entry
        
        cell.textLabel!.text = entry.text
        
        return cell
    }
}

// MARK: - Helper methods

extension EntryDataSource {
    
    func entryAtIndexPath(indexPath: NSIndexPath) -> Entry {
        
        return fetchedResultsController.objectAtIndexPath(indexPath) as! Entry
    }
}