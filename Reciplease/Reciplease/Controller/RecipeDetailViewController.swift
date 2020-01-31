//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by pith on 27/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit

class RecipeDetail: UIViewController {

    @IBOutlet weak var buttonItem: UIBarButtonItem!
    @IBOutlet weak private var recipeView: UIImageView!
    @IBOutlet weak private var recipeNameLabel: UILabel!
    @IBOutlet weak private var ingredientsLabel: UILabel!

    var recipe: Recipe!
    private let favoriteRepository = FavoriteRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Present ingredients list
        let ingredientsArray = recipe.ingredientLines.joined(separator: "\n - ")
        ingredientsLabel.text = ingredientsArray

        // Present recipe name
        recipeNameLabel.text = recipe.label

        // Present recipe image
        let urlString = recipe.image
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                recipeView.image = UIImage(data: data)
            } catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }
    }

    @IBAction private func saveOrDelete(_ sender: UIBarButtonItem) {
        if buttonItem.tintColor == .white {
            buttonItem.tintColor = .green
            // Add the recipe to favorite (CoreData)
            favoriteRepository.saveRecipe(recipeFav: recipe)
        } else {
            buttonItem.tintColor = .white
            // Delete the recipe from Core Data
            favoriteRepository.delete(object: recipe)
        }
    }

    // Throw recipe to next VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipeDirections {
            destinationVC.recipeURLString = recipe.url
        }
    }
}

