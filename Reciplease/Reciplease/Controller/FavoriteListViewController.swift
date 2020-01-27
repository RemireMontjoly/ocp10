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
    private var rcpArray = [Recipe]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        rcpArray = repoFav.getRecipeFav()
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.reloadData()
        if rcpArray.count == 0 {
            emptyFavoriteList()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipeDetail {
            guard let row = tableView.indexPathForSelectedRow?.row else { return }
            destinationVC.buttonItem.tintColor = .green
            destinationVC.recipe = rcpArray[row]
        }
    }

    private func emptyFavoriteList() {
        let alert = UIAlertController(title: "No favorite recipe yet!", message: "To add a favorite, just tap on the star.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension FavoriteList: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromFavToDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rcpArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            fatalError("Can't create CustomCell")
        }
        cell.configure(recipe: rcpArray[indexPath.row])

        return cell
    }
}
