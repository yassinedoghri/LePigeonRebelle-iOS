//
//  User+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var isDefaultUser: Bool
    @NSManaged public var debtsOwing: NSSet?
    @NSManaged public var debtsPaying: NSSet?
    @NSManaged public var userGroupList: NSSet?

}

// MARK: Generated accessors for debtsOwing
extension User {

    @objc(addDebtsOwingObject:)
    @NSManaged public func addToDebtsOwing(_ value: Debt)

    @objc(removeDebtsOwingObject:)
    @NSManaged public func removeFromDebtsOwing(_ value: Debt)

    @objc(addDebtsOwing:)
    @NSManaged public func addToDebtsOwing(_ values: NSSet)

    @objc(removeDebtsOwing:)
    @NSManaged public func removeFromDebtsOwing(_ values: NSSet)

}

// MARK: Generated accessors for debtsPaying
extension User {

    @objc(addDebtsPayingObject:)
    @NSManaged public func addToDebtsPaying(_ value: Debt)

    @objc(removeDebtsPayingObject:)
    @NSManaged public func removeFromDebtsPaying(_ value: Debt)

    @objc(addDebtsPaying:)
    @NSManaged public func addToDebtsPaying(_ values: NSSet)

    @objc(removeDebtsPaying:)
    @NSManaged public func removeFromDebtsPaying(_ values: NSSet)

}

// MARK: Generated accessors for userGroupList
extension User {

    @objc(addUserGroupListObject:)
    @NSManaged public func addToUserGroupList(_ value: UserGroup)

    @objc(removeUserGroupListObject:)
    @NSManaged public func removeFromUserGroupList(_ value: UserGroup)

    @objc(addUserGroupList:)
    @NSManaged public func addToUserGroupList(_ values: NSSet)

    @objc(removeUserGroupList:)
    @NSManaged public func removeFromUserGroupList(_ values: NSSet)

}
