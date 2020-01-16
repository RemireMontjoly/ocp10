//
//  CustomCell.swift
//  Reciplease
//
//  Created by pith on 16/01/2020.
//  Copyright © 2020 dino. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var cellRecipeImage: UIImageView!
    @IBOutlet weak var cellRecipeLabel: UILabel!

    //Deux func par défaut: On les garde?????????????????????????????????
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state??????????????????????
    }
    override func prepareForReuse() {
         cellRecipeImage.layer.sublayers = nil
     }

    func configure(label: String, image: String) {
        cellRecipeLabel.text = label
         let urlString = image
         if let imageUrl = URL(string: urlString) {
             do {
                 let data = try Data(contentsOf: imageUrl)
                 cellRecipeImage.image = UIImage(data: data)
                 setGradientBackground()
                 setCustomView()
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

    func setCustomView() {
        if let subView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as? CustomView {
            customView.clipsToBounds = true
            customView.layer.cornerRadius = 5
            customView.layer.borderWidth = 0.5
            customView.layer.borderColor = UIColor.white.cgColor
            customView.addSubview(subView)
        }
    }

}
