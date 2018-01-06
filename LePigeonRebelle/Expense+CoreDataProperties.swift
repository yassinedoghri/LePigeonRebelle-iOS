//
//  Expense+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense");
    }

    @NSManaged public var comment: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var desc: String?
    @NSManaged public var category: ExpenseCategory?
    @NSManaged public var type: ExpenseType?
    @NSManaged public var group: Group?
    @NSManaged public var debts: NSSet?

}

// MARK: Generated accessors for debts
extension Expense {

    @objc(addDebtsObject:)
    @NSManaged public func addToDebts(_ value: Debt)

    @objc(removeDebtsObject:)
    @NSManaged public func removeFromDebts(_ value: Debt)

    @objc(addDebts:)
    @NSManaged public func addToDebts(_ values: NSSet)

    @objc(removeDebts:)
    @NSManaged public func removeFromDebts(_ values: NSSet)

}
