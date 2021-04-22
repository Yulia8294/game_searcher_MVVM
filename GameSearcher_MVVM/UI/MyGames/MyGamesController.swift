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
    
    private var games: [[GameItemViewModel]] {
        viewModel.items.value
    }
    
    private var type: PresentationType = .all
    
    private var viewModel: MyGamesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(with: viewModel)
        viewModel.viewDidLoad()
        collectionViewSetup()
    }
    
    func bind(with viewModel: MyGamesViewModel) {
        viewModel.type.observe(on: self) { [weak self] in self?.onTypeChanged($0) }
    }
    
    private func onTypeChanged(_ type: PresentationType) {
        switch type {
        case .all:
            collectionView.setCollectionViewLayout(MyGamesLayoutManager.createAllGamesLayout(), animated: true)
        case .byYear:
            collectionView.setCollectionViewLayout(MyGamesLayoutManager.createSortedLayout(), animated: true)
        }
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
    
    @IBAction func didPressSwitchLayout(_ sender: UIBarButtonItem) {
        viewModel.didChangePresentationType()
    }
}


extension MyGamesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.cell(SimilarGamesCell.self, for: indexPath).setupGame(games[indexPath.section][indexPath.row])
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        games[section].count
    }
    
}

extension MyGamesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}

extension MyGamesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if type == .all { return UICollectionReusableView() }
        let firstItemInSectionYear = games[indexPath.section].first!.released
        return collectionView.header(HeaderView.self, for: indexPath).setup(String(firstItemInSectionYear.anyString))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return games.count
    }
}




