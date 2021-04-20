//
//  SimilarGamesCollectionViewDataSource.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/3/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class SimilarGamesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var games = [GameItemViewModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var presentingController: UIViewController!
    private weak var collectionView: UICollectionView!
    
    init(_ collection: UICollectionView, presentingVC: UIViewController) {
        super.init()
        collectionView = collection
        presentingController = presentingVC
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.registerCell(SimilarGamesCell.self)
    }
 

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(games[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = GameDetailsController.instantiate("GameDetails")
     //   details.game = data[indexPath.item]
        presentingController.push(details)
    }
}
