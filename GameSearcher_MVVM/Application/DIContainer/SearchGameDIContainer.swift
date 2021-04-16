//
//  GameSearchSceneDIContainer.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/16/21.
//

import UIKit

final class SearchGameDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: String
        let imageDataTransferService: String
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
//MARK: - Search games
    
    func makeSearchViewController(actions: GamesListViewModelActions) -> SearchViewController {
        SearchViewController.create(with: makeGamesListViewModel(actions: actions))
    }
    
    func makeGamesListViewModel(actions: GamesListViewModelActions) -> GamesListViewModel {
        DefaultGamesListViewModel(actions: actions)
    }
    
//MARK: - Game details
    
    func makeGameDetailsDetailsController(game: GameItem) -> GameDetailsController {
        return GameDetailsController()
    }
    
//    func makeGameDetailsViewModel(game: GameItem) -> GameDetailsViewModel {
//
//    }
    
// MARK: - Coordinators

    func makeGameSearchCoordinator(navigationController: UINavigationController) -> GameSearchCoordinator {
        return GameSearchCoordinator(navigationController: navigationController,
                                     dependencies: self)
    }
}

extension SearchGameDIContainer: GameSearchCoordinatorDependencies { }
