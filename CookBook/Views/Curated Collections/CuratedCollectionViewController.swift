//
//  CuratedCollectionViewController.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import UIKit
import Combine

typealias DataSource = UICollectionViewDiffableDataSource<String?, CuratedCollection>
typealias Snapshot = NSDiffableDataSourceSnapshot<String?, CuratedCollection>

class CuratedCollectionViewController: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!

    var viewModelService: CuratedCollectionService!
    private var viewModel: CuratedCollectionViewModel!

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
        mainCollectionView.register(CuratedCollectionCollectionViewCell.self)
    }

    func bindViewModel() {
        viewModel.dataSource = UICollectionViewDiffableDataSource(collectionView: mainCollectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuratedCollectionCollectionViewCell", for: indexPath) as! CuratedCollectionCollectionViewCell
            cell.updateCell(with: model)
            return cell
        })
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
