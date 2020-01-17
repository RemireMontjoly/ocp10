//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by pith on 18/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import Foundation
import Alamofire

//To put in gitignore File
let app_id = "affe061e"
let app_key = "23d0bc574cb76dbbef2f0dae27266921"

struct JsonObject: Decodable {
    let hits: [Hit]
}
struct Hit: Decodable {
    let recipe: Recipe
}
//Test passing var instead of let
struct Recipe: Decodable {
    var label: String
    var image: String
    var url: String
    var ingredientLines: [String]
    // let yield: Int
    // let totalTime: Int
}

class RecipeRepository {

       func getRecipes(ingredient: String, completion: @escaping (Result<JsonObject, AFError>) -> ()) {

        let parameters: Parameters = ["app_id": app_id, "app_key": app_key, "q": ingredient]

         AF.request("https://api.edamam.com/search?", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseDecodable(of: JsonObject.self) { response in
            completion(response.result)
         }
    }
}
