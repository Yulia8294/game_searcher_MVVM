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
        GameDetailsController.create(with: makeGameDetailsViewModel(game: game),
                                     gameViewModel: makeGameItemViewModel(game: game))
    }
    
    func makeGameDetailsViewModel(game: GameItem) -> GameDetailsViewModel {
        DefaultGameDetailsViewModel(game: game)
    }
    
    func makeGameItemViewModel(game: GameItem) -> GameItemViewModel {
        GameItemViewModel(game: game)
    }
    
// MARK: - Coordinators

    func makeGameSearchCoordinator(navigationController: UINavigationController) -> GameSearchCoordinator {
        GameSearchCoordinator(navigationController: navigationController,
                                     dependencies: self)
    }
}

extension SearchGameDIContainer: GameSearchCoordinatorDependencies { }
