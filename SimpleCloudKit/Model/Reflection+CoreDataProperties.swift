//
//  Reflection+CoreDataProperties.swift
//  SimpleCloudKit
//
//  Created by Muhammad Syabran on 04/09/20.
//  Copyright © 2020 ADA. All rights reserved.
//
//

import Foundation
import CoreData


extension Reflection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reflection> {
        return NSFetchRequest<Reflection>(entityName: "Reflection")
    }

    @NSManaged public var date: Int16
    @NSManaged public var learned: String?

}
