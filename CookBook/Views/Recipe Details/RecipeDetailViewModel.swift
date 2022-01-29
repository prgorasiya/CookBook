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
    
    func createDataSource(from recipe: Recipe) {
        let recipeImage = RecipeImageCellModel(urlString: recipe.imageUrl)
        let basicDetails = BasicDetailCellModel(title: recipe.title, user: recipe.user, story: recipe.story)
        let ingredients = IngredientsCellModel(ingredients: recipe.ingredients)
        let steps = StepsCellModel(steps: recipe.steps.map({ $0.description }))
        
        updateDataSource([recipeImage, basicDetails, ingredients, steps])
    }
    
    func updateDataSource(_ recipes: [AnyHashable]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([""])
        snapshot.appendItems(recipes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
