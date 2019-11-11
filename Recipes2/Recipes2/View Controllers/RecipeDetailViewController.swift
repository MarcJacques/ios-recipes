//
//  RecipeDetailViewController.swift
//  Recipes2
//
//  Created by Marc Jacques on 11/10/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let recipe = recipe else { return }
        if self.isViewLoaded {
            recipeLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


