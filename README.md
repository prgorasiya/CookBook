# Cookpad Challenge (CookBook)
This project demonstartes use of some of the APIs from <a href="https://cookpad.github.io/global-mobile-hiring/" target="_blank">Cookpad's challenge</a>.

### Application Overview
1) Project consists 3 screens
    - Curated collections
    - Recipes list of a collection
    - Recipe details

2) Min deployment version iOS 13.0 and supports iPhones in portrait orientation
3) Project is based on UIKit, written entierly in Swift 5 and uses storyboards and XIBs, using Xcode 13.2.1
4) No use of external dependencies
5) First screen loads list of collections and displays them in a collection view
6) 2nd screen loads list of recipes of a selected collection, and shows them in a table view
7) 3rd screen shows details of the selected recipe, using table view

### Usage
1) Checkout the main branch of the project
2) Since there's no external dependency, project should complie successfully right away

### Architectural Overview
1) Project consists 2 main modules
    - Curated Collections (to load collections)
    - Recipe (to load recipes from a given collectionId)

2) There are 2 more modules
    - APIClient (handles API communication)
    - Mapper (handles mapping response data to models)

3) Views folder consists different classes and models which are used in ViewControllers
4) Use of dependency injection and SOLID principles
5) MVVM design pattern with bindings using Diffable Datasource
6) Consists unit tests for both the main modules


### Extension
Project can be easily extended to include more screens as there are a few more APIs in the API documentation. I would like to add a collection view to show images which are attached with some of the Steps of a recipe details (I didnt add that due to time crunch).
I would add more modules as needed using TDD approach.

Additionally, I would add a tab bar with 2 tabs, which would have existing Collections screen and a new screen to show all the recipes using api/recipes. I couldn't find pagination information for any of the API, so If I were to add all recipes screen I would need that information.

Search functionality for all recipes screen could also be implemented with the use of CoreData and Combine frameworks.
