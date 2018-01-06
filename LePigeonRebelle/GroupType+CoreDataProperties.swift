//
//  GroupType+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension GroupType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupType> {
        return NSFetchRequest<GroupType>(entityName: "GroupType");
    }

    @NSManaged public var icon: String?
    @NSManaged public var wording: String?
    @NSManaged public var groups: NSSet?

}

// MARK: Generated accessors for groups
extension GroupType {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: Group)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: Group)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}
