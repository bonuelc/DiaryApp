//
//  Entry.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/7/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import Foundation
import CoreData


class Entry: NSManagedObject {
    
    static let entityName = "\(Entry.self)"

    class func entry(inManagedObjectContext moc: NSManagedObjectContext) -> Entry {
        
        let entry = NSEntityDescription.insertNewObjectForEntityForName(Entry.entityName, inManagedObjectContext: moc) as! Entry
        
        return entry
    }
    
    static var allEntriesRequest: NSFetchRequest = {
        let request = NSFetchRequest(entityName: Entry.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        return request
    }()
}
