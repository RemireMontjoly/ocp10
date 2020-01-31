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
    private let repository = RecipeRepository.shared
    private var ingredientsArray = [String]()

    @IBOutlet weak private var searchButton: UIButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var ingredientTextField: UITextField!
    @IBOutlet weak private var ingredientListLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction private func addButton(_ sender: UIButton) {
        if ingredientsArray.count == 0 {
            ingredientListLabel.text = "- \(ingredientTextField.text ?? "")"
        } else {
            ingredientListLabel.text?.append("\n- \(ingredientTextField.text ?? "")")
        }
        clearTextField()
    }

    @IBAction private func clearButton(_ sender: UIButton) {
        ingredientsArray.removeAll()
        ingredientListLabel.text = nil
    }

    @IBAction private func searchButton(_ sender: UIButton) {
        let ingredients = ingredientsArray.joined(separator: ",")
        searchForRecipes(ingredient: ingredients)
    }

    private func clearTextField() {
        ingredientsArray.append(ingredientTextField.text ?? "")
        ingredientTextField.text = nil
        view.endEditing(true)
    }

    private func searchForRecipes(ingredient: String) {
        toggleActivityIndicator(shown: true)
        repository.getRecipes(ingredient: ingredient) { result in
            self.toggleActivityIndicator(shown: false)
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
