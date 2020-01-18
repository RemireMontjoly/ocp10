//
//  FavoriteRepository.swift
//  Reciplease
//
//  Created by pith on 27/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import Foundation
import CoreData

class RecipeFav: NSManagedObject {
    //Managed by CoreData
}

class FavoriteRepository {

    func saveRecipe(label: String, image: String, url: String, ingredients: [String]) {

        let recipe = RecipeFav(context: AppDelegate.viewContext)
        recipe.label = label
        recipe.image = image
        recipe.url = url
        recipe.ingredients = ingredients   //.map{(NSString(string: $0) as String)}
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("Error while saving: \(error)")
        }
    }

    func getRecipeFav() -> [RecipeFav] {

        let request: NSFetchRequest<RecipeFav> = RecipeFav.fetchRequest()
        guard let recipeFav = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipeFav
    }
    
    func delete(object: NSManagedObject) {
        AppDelegate.viewContext.delete(object)
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}





