//
//  CustomCell.swift
//  Reciplease
//
//  Created by pith on 16/01/2020.
//  Copyright © 2020 dino. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak private var ratesLabel: UILabel!
    @IBOutlet weak private var cookTime: UILabel!
    @IBOutlet weak private var customView: UIView!
    @IBOutlet weak private var cellRecipeImage: UIImageView!
    @IBOutlet weak private var cellRecipeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setGradientBackground()
        setRateAndTime()
    }

    func configure(recipe: Recipe) {
        cellRecipeLabel.text = recipe.label
        let urlString = recipe.image
        if let imageUrl = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: imageUrl)
                cellRecipeImage.image = UIImage(data: data)

            } catch let err {
                //Maybe a pop-up ?
                print("Error: \(err.localizedDescription)")
            }
        }
    }

    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear, UIColor.black.cgColor]
        gradientLayer.locations = [0.6,1]
        cellRecipeImage.layer.insertSublayer(gradientLayer, at: 0)
    }

    func setRateAndTime() {
        customView.layer.cornerRadius = 5
        customView.layer.borderWidth = 0.5
        customView.layer.borderColor = UIColor.white.cgColor

    }
}
