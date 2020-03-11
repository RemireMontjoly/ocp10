//
//  RecipeFav+CoreDataProperties.swift
//  Reciplease
//
//  Created by pith on 11/03/2020.
//  Copyright © 2020 dino. All rights reserved.
//
//

import Foundation
import CoreData


extension RecipeFav {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeFav> {
        return NSFetchRequest<RecipeFav>(entityName: "RecipeFav")
    }

    @NSManaged public var image: String//?
    @NSManaged public var ingredients: [String]//?
    @NSManaged public var label: String//?
    @NSManaged public var totalTime: Int16
    @NSManaged public var url: String//?
    @NSManaged public var yield: Int16

}
