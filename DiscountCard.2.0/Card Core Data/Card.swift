//
//  Card+CoreDataClass.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/1/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//
//

import Foundation
import CoreData

public class Card: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }
    
    @NSManaged public var backImage: String?
    @NSManaged public var barcode: String?
    @NSManaged public var date: Date?
    @NSManaged public var descriptionCard: String?
    @NSManaged public var filterColor: String?
    @NSManaged public var frontImage: String?
    @NSManaged public var title: String?
    
    convenience init() {
        self.init(context: CardManager.getContext())
    }
}
