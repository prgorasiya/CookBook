//
//  CuratedCollectionViewController.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import UIKit

typealias CollectionDataSource = UICollectionViewDiffableDataSource<String?, CuratedCollection>
typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<String?, CuratedCollection>

class CuratedCollectionViewController: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!

    var recipeService: RecipeService!
    var viewModelService: CuratedCollectionService!
    private var viewModel: CuratedCollectionViewModel!

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemSize: CGFloat = (UIScreen.main.bounds.width - 40) / 2
        layout.itemSize = CGSize(width: itemSize, height: 200)
        layout.minimumInteritemSpacing = spacing/2
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CuratedCollectionViewModel(service: viewModelService, delegate: self)
        setupUI()
        bindViewModel()
        viewModel.loadCollections()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit CuratedCollectionViewController screen......")
    }

    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        mainCollectionView.register(CuratedCollectionCollectionViewCell.self)
        mainCollectionView.collectionViewLayout = collectionViewLayout
    }

    func bindViewModel() {
        viewModel.dataSource = UICollectionViewDiffableDataSource(collectionView: mainCollectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell: CuratedCollectionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.updateCell(with: model)
            return cell
        })
    }

    func navigateToRecipeListViewWith(collection: CuratedCollection) {
        recipeService.collectionId = collection.id
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        let recipeListView = storyboard.instantiateViewController(withIdentifier: "RecipeListViewController") as! RecipeListViewController
        recipeListView.viewModelService = recipeService
        recipeListView.collection = collection
        navigationController?.pushViewController(recipeListView, animated: true)
    }
}

extension CuratedCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCollection = viewModel.snapshot.itemIdentifiers[indexPath.item]
        navigateToRecipeListViewWith(collection: selectedCollection)
    }
}

extension CuratedCollectionViewController: CuratedCollectionViewModelDelegate {
    func startLoading() {
        
    }

    func finishLoading() {

    }

    func finishLoadingWithError(_ error: Error) {

    }
}
