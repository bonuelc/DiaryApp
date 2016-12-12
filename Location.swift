//
//  Location.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/12/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation


class Location: NSManagedObject {
    
    static let entityName = "\(Location.self)"
    
    class func location(withPlacemark placemark: CLPlacemark?, inManagedObjectContext moc: NSManagedObjectContext) -> Location? {
        
        guard let placemark = placemark, cllocation = placemark.location else { return nil }
        
        let location = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: moc) as! Location
        
        location.latitude = cllocation.coordinate.latitude
        location.longitude = cllocation.coordinate.longitude
        
        location.name = placemark.name
        location.city = placemark.locality
        location.area = placemark.administrativeArea
        
        return location
    }
}
