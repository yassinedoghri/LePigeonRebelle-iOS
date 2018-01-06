//
//  Group+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group");
    }

    @NSManaged public var name: String?
    @NSManaged public var expenses: NSSet?
    @NSManaged public var type: GroupType?
    @NSManaged public var userGroupList: NSSet?

}

// MARK: Generated accessors for expenses
extension Group {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

// MARK: Generated accessors for userGroupList
extension Group {

    @objc(addUserGroupListObject:)
    @NSManaged public func addToUserGroupList(_ value: UserGroup)

    @objc(removeUserGroupListObject:)
    @NSManaged public func removeFromUserGroupList(_ value: UserGroup)

    @objc(addUserGroupList:)
    @NSManaged public func addToUserGroupList(_ values: NSSet)

    @objc(removeUserGroupList:)
    @NSManaged public func removeFromUserGroupList(_ values: NSSet)

}
