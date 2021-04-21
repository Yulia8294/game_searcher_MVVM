//
//  SearchGameCoordinator.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/16/21.
//

import UIKit

protocol GameSearchCoordinatorDependencies  {
    func makeSearchViewController(actions: GamesListViewModelActions) -> SearchViewController
    func makeGameDetailsDetailsController(game: GameItem) -> GameDetailsController
    func makeMyGamesViewController(actions: MyGamesViewModelActions) -> MyGamesViewController
}

final class GameSearchCoordinator {
    
    private let dependencies: GameSearchCoordinatorDependencies
    
    private weak var navigationController: UINavigationController?
    private weak var gamesListVC: SearchViewController?
    
    init(navigationController: UINavigationController,
         dependencies: GameSearchCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = GamesListViewModelActions(showGameDetails: showGameDetails,
                                                showMyGames: showMyGames)
        
        let searchVC = dependencies.makeSearchViewController(actions: actions)
        navigationController?.pushViewController(searchVC, animated: true)
        gamesListVC = searchVC
    }
    
    private func showMyGames() {
        let actions = MyGamesViewModelActions(showGameDetails: showGameDetails)
        let vc = dependencies.makeMyGamesViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showGameDetails(game: GameItem) {
        let vc = dependencies.makeGameDetailsDetailsController(game: game)
        navigationController?.pushViewController(vc, animated: true)
    }
}
