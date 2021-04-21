//
//  MyGamesController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 3/1/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import RealmSwift

enum PresentationType {
    case all
    case byYear
}

class MyGamesViewController: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var games: [GameItemViewModel] = []
    
    private var groupedGames = [[GameItemViewModel]]()
    private var type: PresentationType = .all
    
    private var viewModel: MyGamesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembleGroupedGames()
        collectionViewSetup()
    }
    
    static func create(with viewModel: MyGamesViewModel) -> MyGamesViewController {
        let view = MyGamesViewController.instantiate("MyGames")
        view.viewModel = viewModel
        return view
    }
    
    private func collectionViewSetup() {
        collectionView.collectionViewLayout = MyGamesLayoutManager.createAllGamesLayout()
        collectionView.registerCell(SimilarGamesCell.self)
        collectionView.registerHeader(HeaderView.self)
    }
    
    private func assembleGroupedGames() {
        let groupedUsers = Dictionary(grouping: games) { $0.released.anyString }
        let sortedKeys = groupedUsers.keys.sorted { $0 > $1 }
        sortedKeys.forEach { (key) in
            if let values = groupedUsers[key] {
                groupedGames.append(values)
            }
        }
    }
    
    @IBAction func didPressSwitchLayout(_ sender: UIBarButtonItem) {
        if type == .all {
            type = .byYear
            collectionView.setCollectionViewLayout(MyGamesLayoutManager.createSortedLayout(), animated: true)
        } else if type == .byYear {
            type = .all
            collectionView.setCollectionViewLayout(MyGamesLayoutManager.createAllGamesLayout(), animated: true)
        }
    }
}


extension MyGamesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .all:
            return collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(games[indexPath.row])
        case .byYear:
            return collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(groupedGames[indexPath.section][indexPath.row])
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        type == .all ? games.count : groupedGames[section].count
    }
    
}

extension MyGamesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
}

extension MyGamesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if type == .all { return UICollectionReusableView() }
        let firstItemInSectionYear = groupedGames[indexPath.section].first!.released
        return collectionView.header(HeaderView.self, for: indexPath).setup(String(firstItemInSectionYear.anyString))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return type == .all ? 1 : groupedGames.count
    }
}




