//
//  SearchScreen.swift
//  Reciplease
//
//  Created by pith on 17/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit
import Alamofire

class SearchScreen: UIViewController, UITextFieldDelegate {

    private var recipes = [Recipe]()
    private var ingredientsArray = [String]()
    private let recipeRepository = RecipeRepository()

    @IBOutlet weak private var searchButton: UIButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var ingredientTextField: UITextField!
    @IBOutlet weak private var ingredientListLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextField.delegate = self
    }

    @IBAction private func addButton(_ sender: UIButton) {
        guard ingredientTextField.text?.isEmpty == false else {
            return
        }
        if ingredientsArray.count == 0 {
            ingredientListLabel.text = "- \(ingredientTextField.text ?? "")"
        } else {
            ingredientListLabel.text?.append("\n- \(ingredientTextField.text ?? "")")
        }
        clearTextField()
    }
    //            if ingredientTextField.text?.isEmpty ?? true {
    //                return
    //            } else {
    //                if ingredientsArray.count == 0 {
    //                    ingredientListLabel.text = "- \(ingredientTextField.text ?? "")"
    //                } else {
    //                    ingredientListLabel.text?.append("\n- \(ingredientTextField.text ?? "")")
    //                }
    //                clearTextField()
    //            }
    //    }
    @IBAction private func clearButton(_ sender: UIButton) {
        ingredientsArray.removeAll()
        ingredientListLabel.text = nil
    }

    @IBAction private func searchButton(_ sender: UIButton) {
        let ingredients = ingredientsArray.joined(separator: "&")
        searchForRecipes(ingredient: ingredients)
    }

    private func clearTextField() {
        ingredientsArray.append(ingredientTextField.text ?? "")
        ingredientTextField.text = nil
        view.endEditing(true)
    }

    private func noRecipePopUp() {
        let alert = UIAlertController(title: "No recipe!", message: "Please enter ingredient.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    private func searchForRecipes(ingredient: String) {

        toggleActivityIndicator(shown: true)
        recipeRepository.getRecipes(ingredient: ingredient) { result in
            self.toggleActivityIndicator(shown: false)
            switch result {
            case.success(let success):
                self.recipes = success.hits.map { $0.recipe }
                if self.recipes.isEmpty {
                    self.noRecipePopUp()
                } else {
                    self.performSegue(withIdentifier: "recipesListSegue", sender: self)
                }
            case.failure(let failure):
                self.noRecipePopUp()
                print("Error occures:", failure)
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipesList {
            destinationVC.recipes = recipes
        }
    }
}
