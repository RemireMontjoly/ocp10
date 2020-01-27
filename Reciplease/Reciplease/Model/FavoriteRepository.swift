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

    func saveRecipe(recipeFav: Recipe) {

        let recipe = RecipeFav(context: AppDelegate.viewContext)
        recipe.image = recipeFav.image
        recipe.ingredients = recipeFav.ingredientLines
        recipe.label = recipeFav.label
        recipe.url = recipeFav.url
        recipe.totalTime = recipeFav.totalTime
        recipe.yield = recipeFav.yield
        do {
            try AppDelegate.viewContext.save()
        } catch let error {
            print("Error while saving: \(error)")
        }
    }

    func getRecipeFav() -> [Recipe] {

        let request: NSFetchRequest<RecipeFav> = RecipeFav.fetchRequest()
        var recipe = Recipe(label: "", image: "", url: "", ingredientLines: [""], yield: 0, totalTime: 0)
        var recipeArray = [Recipe]()
        do {
            let recipeFav = try AppDelegate.viewContext.fetch(request)

            for i in recipeFav {
                recipe.image = i.image ?? ""
                recipe.ingredientLines = i.ingredients ?? []
                recipe.label = i.label ?? ""
                recipe.url = i.url ?? ""
                recipe.yield = i.yield
                recipe.totalTime = i.totalTime
                recipeArray.append(recipe)
            }
        } catch let error {
            print ("Error fetching data from context \(error)")
        }
        return recipeArray
    }
    
    func delete(object: Recipe) {
        let request: NSFetchRequest<RecipeFav> = RecipeFav.fetchRequest()
        let recipeFav = try! AppDelegate.viewContext.fetch(request)

        for i in recipeFav {
            if i.image == object.image && i.ingredients == object.ingredientLines && i.label == object.label && i.url == object.url {
                AppDelegate.viewContext.delete(i)
                do {
                    try AppDelegate.viewContext.save()
                } catch let error {
                    print("Error deleting data from context \(error)")
                }
            }
        }
    }
}





