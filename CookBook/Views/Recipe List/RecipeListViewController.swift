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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
