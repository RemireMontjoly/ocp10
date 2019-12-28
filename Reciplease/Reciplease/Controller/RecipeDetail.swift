//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by pith on 27/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit

class RecipeDetail: UIViewController {

    @IBOutlet weak var recipeView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!

    var recipe: Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()
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
        saveLabel(label: recipe.label)
    }

    private func saveLabel(label: String) {
        let recipeLabel = RecipeFav(context: AppDelegate.viewContext)
        recipeLabel.label = recipe.label
       try? AppDelegate.viewContext.save()

    }
    
    //MARK: - Throw recipe to next VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipeDirections {
            destinationVC.recipeURLString = recipe.url
        }
    }
}
