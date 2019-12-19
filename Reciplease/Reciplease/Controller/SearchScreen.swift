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
  //  private let repository = RecipeRepository()
    private var ingredientsArray = [String]()

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientListLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addButton(_ sender: UIButton) {
        if ingredientsArray.count == 0 {
            ingredientListLabel.text = "- \(ingredientTextField.text ?? "")"
            clearTextField()
        } else {
            ingredientListLabel.text?.append("\n- \(ingredientTextField.text ?? "")")
            clearTextField()
        }
    }

    @IBAction func clearButton(_ sender: UIButton) {
        ingredientsArray.removeAll()
        ingredientListLabel.text = nil
    }

    @IBAction func searchButton(_ sender: UIButton) {
        let ingredients = ingredientsArray.joined(separator: ",")
        searchForRecipes(ingredient: ingredients)
    }

    func searchForRecipes(ingredient: String) {
        let parameters: Parameters = ["app_id": app_id, "app_key": app_key, "q": ingredient]
        AF.request("https://api.edamam.com/search?", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseDecodable(of: JsonObject.self) { response in
            print(response)
            switch response.result {
            case.success(let success):
                self.recipes = success.hits.map { $0.recipe }
                print(success.hits)
            case.failure(let failure):
                print(failure)
            }
        }
    }

    func clearTextField() {
        ingredientsArray.append(ingredientTextField.text ?? "")
        ingredientTextField.text = nil
        view.endEditing(true)
    }
}