//
//  CuratedCollectionViewModel.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation
import UIKit
import Combine

protocol CuratedCollectionViewModelDelegate: AnyObject {
    func startLoading()
    func finishLoading()
    func finishLoadingWithError(_ error: Error)
}

struct CuratedCollectionViewModel {
    let service: CuratedCollectionService!
    weak var delegate: CuratedCollectionViewModelDelegate?

    var cancellables: Set<AnyCancellable> = []
    var dataSource: DataSource!
    var snapshot = Snapshot()

    init(service: CuratedCollectionService, delegate: CuratedCollectionViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }

    func loadCollections() {
        
    }
}
