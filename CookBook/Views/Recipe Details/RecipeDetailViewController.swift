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
    @IBOutlet weak var backButton: UIButton!

    var recipe: Recipe!
    private var viewModel: RecipeDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = RecipeDetailViewModel()
        setupUI()
        bindViewModel()
        viewModel.createDataSource(from: recipe)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit RecipeDetailViewController screen......")
    }

    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
        backButton.layer.shadowColor = UIColor.darkGray.cgColor
        backButton.layer.shadowRadius = 2
        backButton.layer.shadowOpacity = 0.8
        backButton.layer.shadowOffset = CGSize(width: 1, height: 1)

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.tableFooterView = UIView()
        tableView.register(RecipeImageTableViewCell.self)
        tableView.register(DetailsTableViewCell.self)
        tableView.register(IngredientsTableViewCell.self)
        tableView.register(StepsTableViewCell.self)
    }

    func bindViewModel() {
        viewModel.dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            switch model {
            case is RecipeImageCellModel:
                let cell: RecipeImageTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.selectionStyle = .none
                cell.updateCell(with: model as! RecipeImageCellModel)
                return cell
            case is BasicDetailCellModel:
                let cell: DetailsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.selectionStyle = .none
                cell.updateCell(with: model as! BasicDetailCellModel)
                return cell
            case is IngredientsCellModel:
                let cell: IngredientsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.selectionStyle = .none
                cell.updateCell(with: model as! IngredientsCellModel)
                return cell
            case is StepsCellModel:
                let cell: StepsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.selectionStyle = .none
                cell.updateCell(with: model as! StepsCellModel)
                return cell
            default:
                return nil
            }
        })
    }

    @IBAction func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
