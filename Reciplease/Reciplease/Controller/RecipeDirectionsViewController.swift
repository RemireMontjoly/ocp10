//
//  RecipeDirections.swift
//  Reciplease
//
//  Created by pith on 27/12/2019.
//  Copyright © 2019 dino. All rights reserved.
//

import UIKit
import WebKit

class RecipeDirections: UIViewController {

    @IBOutlet weak private var webView: WKWebView!
    var recipeURLString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        if let recipeURLString = URL(string: recipeURLString) {
            webView.load(URLRequest(url: recipeURLString))
        }
    }
}
