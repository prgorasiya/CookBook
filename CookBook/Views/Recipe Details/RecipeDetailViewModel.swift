//
//  RecipeDetailViewModel.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation

class RecipeDetailViewModel {
    var dataSource: RecipeDetailDataSource!
    var snapshot = RecipeDetailSnapshot()

    func createDataSource() {

    }

    func updateDataSource(_ recipes: [AnyHashable]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([""])
        snapshot.appendItems(recipes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}