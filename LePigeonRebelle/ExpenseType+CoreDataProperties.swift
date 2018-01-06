//
//  ExpenseType+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension ExpenseType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseType> {
        return NSFetchRequest<ExpenseType>(entityName: "ExpenseType");
    }

    @NSManaged public var wording: String?
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension ExpenseType {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}
