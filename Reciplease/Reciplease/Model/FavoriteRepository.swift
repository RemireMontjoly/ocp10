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

class FavoriteRepository {

    let persistentContainer: NSPersistentContainer

    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }

    //MARK: Init with the default container for production environment
    convenience init () {
        self.init(container: AppDelegate.persistentContainer)
    }

    //MARK: CRUD
    func addRecipeToFav(recipeFav: Recipe) {

        let recipe = RecipeFav(context: persistentContainer.viewContext)
        recipe.image = recipeFav.image
        recipe.ingredients = recipeFav.ingredientLines
        recipe.label = recipeFav.label
        recipe.url = recipeFav.url
        recipe.totalTime = recipeFav.totalTime
        recipe.yield = recipeFav.yield
        save()

    }

    func getRecipeFav() -> [Recipe] {

        let request: NSFetchRequest<RecipeFav> = RecipeFav.fetchRequest()
        var recipe = Recipe(label: "", image: "", url: "", ingredientLines: [""], yield: 0, totalTime: 0)
        var recipeArray = [Recipe]()
        do {
            let recipeFav = try persistentContainer.viewContext.fetch(request)
            for i in recipeFav {
                recipe.image = i.image// ?? ""
                recipe.ingredientLines = i.ingredients// ?? []
                recipe.label = i.label// ?? ""
                recipe.url = i.url// ?? ""
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
        let recipeFav = try! persistentContainer.viewContext.fetch(request)

        for i in recipeFav {
            if i.image == object.image && i.ingredients == object.ingredientLines && i.label == object.label && i.url == object.url {
                persistentContainer.viewContext.delete(i)
                save()
            }
        }
    }

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

//    func save() {
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//    }
}





