//
//  RecipeRepository.swift
//  Reciplease
//
//  Created by pith on 18/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import Foundation
import Alamofire

let appId = app_id
let appKey = app_key

struct JsonObject: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    var label: String
    var image: String
    var url: String
    var ingredientLines: [String]
    var yield: Int16
    var totalTime: Int16
}

protocol Fetching {
    func getRecipes(ingredient: String, completion: @escaping (Result<JsonObject, AFError>) -> ())
}


class RecipeRepository {
    
    func getRecipes(ingredient: String, completion: @escaping (Result<JsonObject, AFError>) -> ()) {
        
        let parameters: Parameters = ["app_id": appId, "app_key": appKey, "q": ingredient]

        //Cancel a eventual task, in order to avoid multiple calls
        let sessionManager = Alamofire.Session.default
        sessionManager.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            dataTasks.forEach { $0.cancel()}
        }
        
        AF.request("https://api.edamam.com/search?", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseDecodable(of: JsonObject.self) { response in
            completion(response.result)
        }
    }
}
