//
//  User_Expense+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension User_Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User_Expense> {
        return NSFetchRequest<User_Expense>(entityName: "User_Expense");
    }

    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var expense: Expense?
    @NSManaged public var userPaying: User?
    @NSManaged public var userOwing: User?

}
