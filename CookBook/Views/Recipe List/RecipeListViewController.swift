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

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit RecipeListViewController screen......")
    }

    func setupUI() {
        navigationController?.navigationBar.isHidden = false
        tableView.tableFooterView = UIView()
        tableView.register(RecipeTableViewCell.self)
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

    }

    func finishLoading() {

    }

    func finishLoadingWithError(_ error: Error) {

    }
}
