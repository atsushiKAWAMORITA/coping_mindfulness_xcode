//
//  StressorContents+CoreDataProperties.swift
//  CopingMindfulness
//
//  Created by 川守田敦史 1 on 2016/06/21.
//  Copyright © 2016年 Atsushi Kawamorita. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension StressorContents {

    @NSManaged var stressorId: NSDecimalNumber?
    @NSManaged var stressorData: String?
    @NSManaged var itemId01: NSDecimalNumber?
    @NSManaged var itemId02: NSDecimalNumber?
    @NSManaged var itemId03: NSDecimalNumber?
    @NSManaged var itemId04: NSDecimalNumber?
    @NSManaged var itemId05: NSDecimalNumber?
    @NSManaged var itemPoint01: NSDecimalNumber?
    @NSManaged var itemPoint02: NSDecimalNumber?
    @NSManaged var itemPoint03: NSDecimalNumber?
    @NSManaged var itemPoint04: NSDecimalNumber?
    @NSManaged var itemPoint05: NSDecimalNumber?

}
