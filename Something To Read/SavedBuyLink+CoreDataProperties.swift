//
//  SavedBuyLink+CoreDataProperties.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//
//

import Foundation
import CoreData


extension SavedBuyLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedBuyLink> {
        return NSFetchRequest<SavedBuyLink>(entityName: "SavedBuyLink")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var origin: SavedBook?

    public var wrappedName: String {
        return name ?? "Unknown name"
    }
    
    public var wrappedUrl: String {
        return url ?? "Unknown url"
    }
}

extension SavedBuyLink : Identifiable {

}
