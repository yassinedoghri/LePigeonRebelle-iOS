//
//  Group+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group");
    }

    @NSManaged public var name: String
    @NSManaged public var groupType: GroupType?
    @NSManaged public var user_group: NSSet?
    @NSManaged public var expense: NSSet?

}

// MARK: Generated accessors for user_group
extension Group {

    @objc(addUser_groupObject:)
    @NSManaged public func addToUser_group(_ value: User_Group)

    @objc(removeUser_groupObject:)
    @NSManaged public func removeFromUser_group(_ value: User_Group)

    @objc(addUser_group:)
    @NSManaged public func addToUser_group(_ values: NSSet)

    @objc(removeUser_group:)
    @NSManaged public func removeFromUser_group(_ values: NSSet)

}

// MARK: Generated accessors for expense
extension Group {

    @objc(addExpenseObject:)
    @NSManaged public func addToExpense(_ value: Expense)

    @objc(removeExpenseObject:)
    @NSManaged public func removeFromExpense(_ value: Expense)

    @objc(addExpense:)
    @NSManaged public func addToExpense(_ values: NSSet)

    @objc(removeExpense:)
    @NSManaged public func removeFromExpense(_ values: NSSet)

}
