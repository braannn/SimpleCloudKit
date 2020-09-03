//
//  Reflection+CoreDataProperties.swift
//  SimpleCloudKit
//
//  Created by Muhammad Syabran on 03/09/20.
//  Copyright © 2020 ADA. All rights reserved.
//
//

import Foundation
import CoreData


extension Reflection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflection> {
        return NSFetchRequest<Reflection>(entityName: "Reflection")
    }

    @NSManaged public var learned: String?
    @NSManaged public var date: Int16

}
