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

    var cancellables: Set<AnyCancellable> = []
    var viewModelService: CuratedCollectionService!
    var viewModel: CuratedCollectionViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CuratedCollectionViewModel(service: viewModelService, delegate: self)
        setupUI()
        bindViewModel()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit CuratedCollectionViewController screen......")
    }

    func setupUI() {

    }

    func bindViewModel() {

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
