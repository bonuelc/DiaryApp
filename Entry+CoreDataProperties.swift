//
//  Entry+CoreDataProperties.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/7/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entry {
    @NSManaged var dateCreated: NSDate?
    @NSManaged var dateModified: NSDate?
    @NSManaged var text: String
}
