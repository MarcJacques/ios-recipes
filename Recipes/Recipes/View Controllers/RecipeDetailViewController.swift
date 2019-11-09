//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Marc Jacques on 11/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    let recipeNetworkClient = RecipesNetworkClient()
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let recipe = recipe,
            presentingViewController?.isViewLoaded == true else { return }
        recipeLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
