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
    
    //    let repoFav = FavoriteRepository()
    //    var recipeFav = [RecipeFav]()
    var recipeFav = RecipeFav.all
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //  recipeFav = repoFav.getRecipeFav()
        tableView.reloadData()
    }
}

extension FavoriteList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return recipeFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeFav", for: indexPath)
        cell.textLabel?.text = recipeFav[indexPath.row].label

        return cell
    }
}
