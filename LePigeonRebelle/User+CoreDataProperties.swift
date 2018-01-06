//
//  User+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var idUser: Int16
    @NSManaged public var name: String?
    @NSManaged public var defaultUser: DefaultUser?
    @NSManaged public var user_expense_Owing: NSSet?
    @NSManaged public var user_group: NSSet?
    @NSManaged public var user_expense_Paying: NSSet?

}

// MARK: Generated accessors for user_expense_Owing
extension User {

    @objc(addUser_expense_OwingObject:)
    @NSManaged public func addToUser_expense_Owing(_ value: User_Expense)

    @objc(removeUser_expense_OwingObject:)
    @NSManaged public func removeFromUser_expense_Owing(_ value: User_Expense)

    @objc(addUser_expense_Owing:)
    @NSManaged public func addToUser_expense_Owing(_ values: NSSet)

    @objc(removeUser_expense_Owing:)
    @NSManaged public func removeFromUser_expense_Owing(_ values: NSSet)

}

// MARK: Generated accessors for user_group
extension User {

    @objc(addUser_groupObject:)
    @NSManaged public func addToUser_group(_ value: User_Group)

    @objc(removeUser_groupObject:)
    @NSManaged public func removeFromUser_group(_ value: User_Group)

    @objc(addUser_group:)
    @NSManaged public func addToUser_group(_ values: NSSet)

    @objc(removeUser_group:)
    @NSManaged public func removeFromUser_group(_ values: NSSet)

}

// MARK: Generated accessors for user_expense_Paying
extension User {

    @objc(addUser_expense_PayingObject:)
    @NSManaged public func addToUser_expense_Paying(_ value: User_Expense)

    @objc(removeUser_expense_PayingObject:)
    @NSManaged public func removeFromUser_expense_Paying(_ value: User_Expense)

    @objc(addUser_expense_Paying:)
    @NSManaged public func addToUser_expense_Paying(_ values: NSSet)

    @objc(removeUser_expense_Paying:)
    @NSManaged public func removeFromUser_expense_Paying(_ values: NSSet)

}
