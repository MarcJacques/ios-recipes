//
//  MainViewController.swift
//  Recipes2
//
//  Created by Marc Jacques on 11/10/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let networkClient = RecipesNetworkClient()
    var filteredRecipes: [Recipe] = []
    var searchController = UISearchController(searchResultsController: nil)
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Recipes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        networkClient.fetchRecipes { allRecipes, error in
            if let error = error {
                NSLog("Error while fetching all recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                if let allRecipes = allRecipes {
                    self.recipes = allRecipes
                }
            }
        }
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredRecipes = recipes.filter { (recipe: Recipe) -> Bool in
            return recipe.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "DetailVCSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? RecipeDetailViewController
            else { return }
        // Pass the selected object to the new view controller.
        let recipe: Recipe
        if isFiltering {
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = recipes[indexPath.row]
        }
        detailVC.recipe = recipe
    }
}
//    guard segue.identifier == "RecipeTableView",
//               let indexPath = tableView.indexPathForSelectedRow,
//               // Get the new view controller using segue.destination.
//               let detailVC = segue.destination as? RecipeDetailViewController
//               else { return }
//           // Pass the selected object to the new view controller.
//           detailVC.recipeLabel.text = allRecipes[indexPath.row].name
//           detailVC.recipeTextView.text = allRecipes[indexPath.row].instructions
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return filteredRecipes.count
        }
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        // Configure the cell...
        let recipe: Recipe
        if isFiltering {
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = recipes[indexPath.row]
        }
        cell.textLabel?.text = recipe.name
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let recipe = recipes[indexPath.row]
    //        performSegue(withIdentifier: "DetailVCSegue", sender: recipe)
    //    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

