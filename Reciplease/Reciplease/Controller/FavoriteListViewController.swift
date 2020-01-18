//
//  FavoriteList.swift
//  Reciplease
//
//  Created by pith on 27/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit
import CoreData

class FavoriteList: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let repoFav = FavoriteRepository()
    var recipeFav = [RecipeFav]()
    var row = Int()

    //Test
    var recipe = Recipe(label: "", image: "", url: "", ingredientLines: [""])
    //

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recipeFav = repoFav.getRecipeFav()
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.reloadData()
    }
//Test
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipeDetail {
            destinationVC.recipe = recipe
            destinationVC.buttonItem.tintColor = .green
            
            
        }
    }
}

extension FavoriteList: UITableViewDelegate, UITableViewDataSource {
//Test
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe.image = recipeFav[indexPath.row].image ?? ""
        recipe.label = recipeFav[indexPath.row].label ?? ""
        recipe.url = recipeFav[indexPath.row].url ?? ""
        recipe.ingredientLines = recipeFav[indexPath.row].ingredients ?? []//.map{String($0)} ?? []

        self.performSegue(withIdentifier: "fromFavToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            fatalError("Error occurs")
        }
        cell.configure(label: recipeFav[indexPath.row].label ?? "", image: recipeFav[indexPath.row].image ?? "")

        return cell
    }
}
