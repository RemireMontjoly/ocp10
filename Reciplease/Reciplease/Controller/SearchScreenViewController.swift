//
//  SearchScreen.swift
//  Reciplease
//
//  Created by pith on 17/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit
import Alamofire

class SearchScreen: UIViewController {

    private var recipes = [Recipe]()
    private let repository = RecipeRepository()
    private var ingredientsArray = [String]()

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientListLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addButton(_ sender: UIButton) {
        if ingredientsArray.count == 0 {
            ingredientListLabel.text = "- \(ingredientTextField.text ?? "")"
        } else {
            ingredientListLabel.text?.append("\n- \(ingredientTextField.text ?? "")")
        }
        clearTextField()
    }

    @IBAction func clearButton(_ sender: UIButton) {
        ingredientsArray.removeAll()
        ingredientListLabel.text = nil
    }

    @IBAction func searchButton(_ sender: UIButton) {
        let ingredients = ingredientsArray.joined(separator: ",")
        searchForRecipes(ingredient: ingredients)
    }

    func clearTextField() {
        ingredientsArray.append(ingredientTextField.text ?? "")
        ingredientTextField.text = nil
        view.endEditing(true)
    }

    func searchForRecipes(ingredient: String) {

        repository.getRecipes(ingredient: ingredient) { result in
            switch result {

            case.success(let success):
                self.recipes = success.hits.map { $0.recipe }
                self.performSegue(withIdentifier: "recipesListSegue", sender: self)
                
            // Maybe add a pop-up for the user?
            case.failure(let failure):
                print("Error occures:", failure)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipesList {
            destinationVC.recipes = recipes
        }
    }
}
