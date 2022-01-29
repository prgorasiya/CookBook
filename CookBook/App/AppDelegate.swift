//
//  AppDelegate.swift
//  CookBook
//
//  Created by paras gorasiya on 25/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = {
        UIWindow(frame: UIScreen.main.bounds)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func makeRootViewController() -> UIViewController {
        let apiManager = APIManager()
        let storyBoard = UIStoryboard(name: "CuratedCollection", bundle: nil)
        let collectionView = storyBoard.instantiateViewController(withIdentifier: "CuratedCollectionViewController") as! CuratedCollectionViewController
        let endPoint = URL(string: RemoteCuratedCollectionAPI.endPoint.rawValue)!
        collectionView.viewModelService = RemoteCuratedCollectionService(url: endPoint, client: apiManager)
        collectionView.recipeService = RemoteRecipeService(url: endPoint, client: apiManager)
        let navigationController = UINavigationController(rootViewController: collectionView)
        return navigationController
    }
}

