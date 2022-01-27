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
        mainCollectionView.register(CuratedCollectionCollectionViewCell.self)
//        let width = (view.frame.width - 40)/2
//        let height = 300.0
//        let layout = mainCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: width, height: height)
//        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.collectionViewLayout = collectionViewLayout
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
