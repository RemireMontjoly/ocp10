//
//  RecipeViewCell.swift
//  Reciplease
//
//  Created by pith on 20/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit

//class RecipeViewCell: UITableViewCell {
//
//    @IBOutlet weak var customView: UIView!
//    @IBOutlet weak var recipeImage: UIImageView!
//    @IBOutlet weak var recipeTitleLabel: UILabel!
//
//    override func prepareForReuse() {
//        recipeImage.layer.sublayers = nil
//    }
//
//    func configure(recipe: Recipe) {
//        // Display recipe name in the cell
//        recipeTitleLabel.text = recipe.label
//        // Display recipe image in the cell
//        let urlString = recipe.image
//        if let imageUrl = URL(string: urlString) {
//            do {
//                let data = try Data(contentsOf: imageUrl)
//                recipeImage.image = UIImage(data: data)
//                setGradientBackground()
//                setCustomView()
//            } catch let err {
//                //Maybe a pop-up ?
//                print("Error: \(err.localizedDescription)")
//            }
//        }
//    }
//
//    func setCustomView() {
//        if let subView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as? CustomView {
//            customView.clipsToBounds = true
//            customView.layer.cornerRadius = 5
//            customView.layer.borderWidth = 0.5
//            customView.layer.borderColor = UIColor.white.cgColor
//            customView.addSubview(subView)
//        }
//    }
//
//    func setGradientBackground() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [UIColor.clear, UIColor.black.cgColor]
//        gradientLayer.locations = [0.6,1]
//        recipeImage.layer.insertSublayer(gradientLayer, at: 0)
//    }
//}
