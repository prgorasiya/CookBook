//
//  CuratedCollectionViewModel.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation
import UIKit

protocol CuratedCollectionViewModelDelegate: AnyObject {
    func startLoading()
    func finishLoading()
    func finishLoadingWithError(_ error: Error)
}

class CuratedCollectionViewModel {
    let service: CuratedCollectionService!
    weak var delegate: CuratedCollectionViewModelDelegate?
    
    var dataSource: CollectionDataSource!
    var snapshot = CollectionSnapshot()
    
    init(service: CuratedCollectionService, delegate: CuratedCollectionViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func loadCollections() {
        delegate?.startLoading()
        service.load { [weak self] result in
            guard let self = self else { return }
            
            self.delegate?.finishLoading()
            switch result {
            case .success(let collection):
                self.updateCollection(collection)
                break
            case .failure(let error):
                self.delegate?.finishLoadingWithError(error)
                break
            }
        }
    }
    
    func updateCollection(_ collection: [CuratedCollection]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([""])
        snapshot.appendItems(collection)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
