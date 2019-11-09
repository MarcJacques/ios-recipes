//
//  MainViewController.swift
//  Recipes
//
//  Created by Marc Jacques on 11/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    var searchController: UISearchController!
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
        guard segue.identifier == "RecipeTableView",
            let indexPath = tableView.indexPathForSelectedRow,
            // Get the new view controller using segue.destination.
            let detailVC = segue.destination as? RecipeDetailViewController
            else { return }
        // Pass the selected object to the new view controller.
        detailVC.recipeLabel.text = allRecipes[indexPath.row].name
        detailVC.recipeTextView.text = allRecipes[indexPath.row].instructions
    }
    
    
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        // Configure the cell...
        
        let recipe = allRecipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        return cell
        
    }
}

