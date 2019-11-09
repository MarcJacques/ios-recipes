//
//  MainViewController.swift
//  Recipes
//
//  Created by Marc Jacques on 11/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
   
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    var searchController: UISearchController!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error while fetching all recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                if let recipes = allRecipes {
                    self.filteredRecipes = recipes
                }
            }
            
            // Do any additional setup after loading the view.
        }
       
    
    }
    
  
       
    
    func filteredReciptes() {
        
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeTableView" {
            // Get the new view controller using segue.destination.
            recipesTableViewController = segue.destination as? RecipesTableViewController
            // Pass the selected object to the new view controller.
        }
    
     }
     
    
}

