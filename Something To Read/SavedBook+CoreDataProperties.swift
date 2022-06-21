//
//  SavedBook+CoreDataProperties.swift
//  Something To Read
//
//  Created by Bartosz Klimek on 20/06/2022.
//
//

import Foundation
import CoreData


extension SavedBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedBook> {
        return NSFetchRequest<SavedBook>(entityName: "SavedBook")
    }

    @NSManaged public var title: String?
    @NSManaged public var bookImage: String?
    @NSManaged public var author: String?
    @NSManaged public var about: String?
    @NSManaged public var relationship: NSSet?

    public var wrappedTitle: String {
        return title ?? "Unknown title"
    }
    
    public var wrappedAuthor: String {
        return author ?? "Unknown author"
    }
    
    public var wrappedBookImage: String {
        return bookImage  ?? "Unknown book image"
    }
    
    public var wrappedAbout: String {
        return about ?? "Unknown description"
    }

    public var wrappedRelationship: [SavedBuyLink] {
        let set = relationship as? Set<SavedBuyLink> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for relationship
extension SavedBook {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: SavedBuyLink)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: SavedBuyLink)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension SavedBook : Identifiable {

}
