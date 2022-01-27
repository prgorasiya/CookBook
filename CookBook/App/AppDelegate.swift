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

    func makeRootViewController() -> CuratedCollectionViewController {
        let storyBoard = UIStoryboard(name: "CuratedCollection", bundle: nil)
        let collectionView = storyBoard.instantiateViewController(withIdentifier: "CuratedCollectionViewController") as! CuratedCollectionViewController
        collectionView.viewModelService = RemoteCuratedCollectionService(client: APIManager())
        return collectionView
    }
}

