//
//  FavoriteRepository.swift
//  Reciplease
//
//  Created by pith on 27/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecipeFav: NSManagedObject {
    //Attributes managed by CoreData -> codegen = extension
}

class FavoriteRepository {

    let persistentContainer: NSPersistentContainer

    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        //self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true?????????
    }

    //MARK: Init with the default container for production environment
    convenience init () {
        self.init(container: AppDelegate.persistentContainer)
    }

    //MARK: CRUD
    func saveRecipe(recipeFav: Recipe) {
        // Old way to create an Entity:
        //        guard let insert = NSEntityDescription.insertNewObject(forEntityName: "RecipeFav", into: AppDelegate.viewContext) as? RecipeFav else { return }
        //        insert.image = recipeFav.image

        let recipe = RecipeFav(context: AppDelegate.viewContext)
        recipe.image = recipeFav.image
        recipe.ingredients = recipeFav.ingredientLines
        recipe.label = recipeFav.label
        recipe.url = recipeFav.url
        recipe.totalTime = recipeFav.totalTime
        recipe.yield = recipeFav.yield
        save()
        //        do {
        //            try AppDelegate.viewContext.save()
        //        } catch let error {
        //            print("Error while saving: \(error)")
        //        }
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
                save()
                //                do {
                //                    try AppDelegate.viewContext.save()
                //                } catch let error {
                //                    print("Error deleting data from context \(error)")
                //                }
            }
        }
    }

    func save() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}





