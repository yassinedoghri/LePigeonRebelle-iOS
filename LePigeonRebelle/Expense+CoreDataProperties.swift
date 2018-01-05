//
//  Expense+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense");
    }

    @NSManaged public var idExpense: Int16
    @NSManaged public var expenseDescription: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var comment: String?
    @NSManaged public var expenseCategory: ExpenseCategory?
    @NSManaged public var expenseType: ExpenseType?
    @NSManaged public var group: Group?
    @NSManaged public var user_expense: NSSet?

}

// MARK: Generated accessors for user_expense
extension Expense {

    @objc(addUser_expenseObject:)
    @NSManaged public func addToUser_expense(_ value: User_Expense)

    @objc(removeUser_expenseObject:)
    @NSManaged public func removeFromUser_expense(_ value: User_Expense)

    @objc(addUser_expense:)
    @NSManaged public func addToUser_expense(_ values: NSSet)

    @objc(removeUser_expense:)
    @NSManaged public func removeFromUser_expense(_ values: NSSet)

}
