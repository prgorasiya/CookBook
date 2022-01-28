//
//  RecipeListViewModel.swift
//  CookBook
//
//  Created by paras gorasiya on 27/01/22.
//

import Foundation

protocol RecipeListViewModelDelegate: AnyObject {
    func startLoading()
    func finishLoading()
    func finishLoadingWithError(_ error: Error)
}

class RecipeListViewModel {
    let service: RecipeService!
    weak var delegate: RecipeListViewModelDelegate?

    var dataSource: RecipeDataSource!
    var snapshot = RecipeSnapshot()

    init(service: RecipeService, delegate: RecipeListViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }

    func loadRecipes() {
        service.load { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let recipes):
                self.updateRecipes(recipes)
                break
            case .failure(let error):
                self.delegate?.finishLoadingWithError(error)
                break
            }
        }
    }

    func updateRecipes(_ recipes: [Recipe]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([""])
        snapshot.appendItems(recipes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
