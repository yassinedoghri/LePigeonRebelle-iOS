//
//  User_Group+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension User_Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User_Group> {
        return NSFetchRequest<User_Group>(entityName: "User_Group");
    }

    @NSManaged public var budget: NSDecimalNumber?
    @NSManaged public var user: User?
    @NSManaged public var group: Group?

}
