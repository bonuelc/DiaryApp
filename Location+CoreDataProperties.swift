//
//  Location+CoreDataProperties.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/12/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var name: String?
    @NSManaged var city: String?
    @NSManaged var area: String?
}
