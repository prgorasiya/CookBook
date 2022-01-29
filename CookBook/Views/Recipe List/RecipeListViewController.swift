//
//  RecipeListViewController.swift
//  CookBook
//
//  Created by paras gorasiya on 27/01/22.
//

import Foundation
import UIKit

typealias RecipeDataSource = UITableViewDiffableDataSource<String?, Recipe>
typealias RecipeSnapshot = NSDiffableDataSourceSnapshot<String?, Recipe>

class RecipeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var collection: CuratedCollection!
    var viewModelService: RecipeService!
    private var viewModel: RecipeListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = collection.title
        
        viewModel = RecipeListViewModel(service: viewModelService, delegate: self)
        setupUI()
        bindViewModel()
        viewModel.loadRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit RecipeListViewController screen......")
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.register(RecipeTableViewCell.self)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func bindViewModel() {
        viewModel.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            let cell: RecipeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.selectionStyle = .none
            cell.updateCell(with: model)
            return cell
        })
    }
    
    func navigateToRecipeDetailsViewWith(recipe: Recipe) {
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        let recipeListView = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        recipeListView.recipe = recipe
        navigationController?.pushViewController(recipeListView, animated: true)
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = viewModel.snapshot.itemIdentifiers[indexPath.row]
        navigateToRecipeDetailsViewWith(recipe: selectedRecipe)
    }
}

extension RecipeListViewController: RecipeListViewModelDelegate {
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    func finishLoadingWithError(_ error: Error) {
        activityIndicator.stopAnimating()
        print(error.localizedDescription)
    }
}
