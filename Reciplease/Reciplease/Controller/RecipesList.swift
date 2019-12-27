//
//  RecipeList.swift
//  Reciplease
//
//  Created by pith on 20/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit
import Foundation

class RecipesList: UIViewController {

    var numberOfRow = 0
    var recipes = [Recipe]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipeDetail {
            guard let row = tableView.indexPathForSelectedRow?.row else { return }
            destinationVC.recipe = recipes[row]
        }
    }
}

extension RecipesList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell") as? RecipeViewCell else { fatalError("Error occurs") }
        cell.configure(recipe: recipes[indexPath.row])
        return cell
    }
}
