//
//  Debt+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension Debt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Debt> {
        return NSFetchRequest<Debt>(entityName: "Debt");
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var expense: Expense?
    @NSManaged public var userOwing: User?
    @NSManaged public var userPaying: User?

}
