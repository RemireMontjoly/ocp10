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

    static var all: [RecipeFav] {
        let request: NSFetchRequest<RecipeFav> = RecipeFav.fetchRequest()
        guard let recipeFav = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipeFav
    }
}

class FavoriteRepository {

    func saveRecipe(label: String, image: String, url: String) {

        let recipe = RecipeFav(context: AppDelegate.viewContext)
        recipe.label = label
        recipe.image = image
        recipe.url = url
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("Error while saving: \(error)")
        }
    }

    //    func getRecipeFav() -> [RecipeFav] {
    //        let request: NSFetchRequest<RecipeFav> = RecipeFav.fetchRequest()
    //            guard let recipeFav = try? AppDelegate.viewContext.fetch(request) else { return [] }
    //            return recipeFav
    //    }

    func delete(){

    }
}





