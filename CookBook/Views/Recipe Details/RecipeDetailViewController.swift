//
//  RecipeDetailViewController.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation
import UIKit

typealias RecipeDetailDataSource = UITableViewDiffableDataSource<String?, AnyHashable>
typealias RecipeDetailSnapshot = NSDiffableDataSourceSnapshot<String?, AnyHashable>

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var recipe: Recipe!
    private var viewModel: RecipeDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = recipe.title

        viewModel = RecipeDetailViewModel()
        setupUI()
        bindViewModel()
        viewModel.createDataSource()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit RecipeDetailViewController screen......")
    }

    func setupUI() {
        navigationController?.navigationBar.isHidden = false
        tableView.tableFooterView = UIView()
    }

    func bindViewModel() {
        viewModel.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            return nil
        })
    }
}
