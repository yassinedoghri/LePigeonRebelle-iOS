//
//  ExpenseCategory+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension ExpenseCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseCategory> {
        return NSFetchRequest<ExpenseCategory>(entityName: "ExpenseCategory");
    }

    @NSManaged public var wording: String?
    @NSManaged public var icon: String?
    @NSManaged public var expense: NSSet?

}

// MARK: Generated accessors for expense
extension ExpenseCategory {

    @objc(addExpenseObject:)
    @NSManaged public func addToExpense(_ value: Expense)

    @objc(removeExpenseObject:)
    @NSManaged public func removeFromExpense(_ value: Expense)

    @objc(addExpense:)
    @NSManaged public func addToExpense(_ values: NSSet)

    @objc(removeExpense:)
    @NSManaged public func removeFromExpense(_ values: NSSet)

}
