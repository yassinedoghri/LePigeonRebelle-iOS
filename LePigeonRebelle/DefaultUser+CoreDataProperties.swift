//
//  DefaultUser+CoreDataProperties.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import Foundation
import CoreData


extension DefaultUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefaultUser> {
        return NSFetchRequest<DefaultUser>(entityName: "DefaultUser");
    }

    @NSManaged public var idDefaultUser: Int16
    @NSManaged public var user: User?

}
