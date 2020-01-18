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
    @IBOutlet weak var recipeView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!

    var recipe: Recipe!
    let favoriteRepository = FavoriteRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //MARK: - Present ingredients list
        let ingredientsArray = recipe.ingredientLines.joined(separator: "\n - ")
        ingredientsLabel.text = ingredientsArray

        //MARK: - Present recipe name
        recipeNameLabel.text = recipe.label

        //MARK: - Present recipe image
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

    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if buttonItem.tintColor == .white {
            buttonItem.tintColor = .green
            // Add the recipe to favorite (CoreData)
            favoriteRepository.saveRecipe(label: recipe.label, image: recipe.image, url: recipe.url, ingredients: recipe.ingredientLines)
        } else {
            buttonItem.tintColor = .white
          //  favoriteRepository.delete(object: recipeFav[row])
            
            print("Call func to delete")
        }
    }

    //MARK: - Throw recipe to next VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipeDirections {
            destinationVC.recipeURLString = recipe.url
        }
    }
}

