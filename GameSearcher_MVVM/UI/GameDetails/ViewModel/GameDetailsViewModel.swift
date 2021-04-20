//
//  GameDetailsViewModel.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/16/21.
//

import Foundation

protocol GameDetailsViewModelInput {
    func viewDidLoad()
    func addedToFavourites()
    func addedToPlayed()
}

protocol GameDetailsViewModelOutput {
    var title: String { get }
    var mainImage: Observable<String?> { get }
    var screenshots: Observable<[String]> { get }
    var similarGames: Observable<[GameItem]> { get }
    var gameViewModel: Observable<GameItemViewModel> { get }

}

protocol GameDetailsViewModel: GameDetailsViewModelInput, GameDetailsViewModelOutput {}

final class DefaultGameDetailsViewModel: GameDetailsViewModel {
   
    // MARK: - OUTPUT

    var title: String
    var mainImage: Observable<String?> = Observable(nil)
    var screenshots: Observable<[String]> = Observable([])
    var similarGames: Observable<[GameItem]> = Observable([])
    
    var gameViewModel: Observable<GameItemViewModel>

    var game: GameItem
    
    init(game: GameItem) {
        self.game = game
        title = game.name
        mainImage.value = game.mainImage
        gameViewModel = Observable(GameItemViewModel(game: game))
    }
}

// MARK: - INPUT. View event methods

extension DefaultGameDetailsViewModel {
    
    func viewDidLoad() {
        fetchDetails()
    }
    
    func addedToFavourites() {
        RealmService.shared.commitWriting {
            game.isFavourite = !game.isFavourite
            RealmService.shared.append(game)
        }
    }
    
    func addedToPlayed() {
        RealmService.shared.commitWriting {
            game.played = !game.played
            RealmService.shared.append(game)
        }
    }
    
//MARK: - Network
    
    private func fetchScreenshots() {
           
        APIService.getScreenshots(game.slug) { [self] error, screenshots in
            if let screens = screenshots {
                self.screenshots.value = screens.map{$0.image}
            }
        }
    }
    
    private func getTrailers() {
//        APIService.getGameTrailers(game.id) { error, trailers in
//            if let trailers = trailers {
//                self.trailersDataSource.set(self.trailersCollectionView, trailers)
//            }
//        }
    }
    
    private func getSimilarGames() {
        APIService.getSimilarGames(1, game.id) { error, games in
            if let games = games {
                self.similarGames.value = games
            }
        }
    }
    
    
    private func fetchDetails() {
        APIService.fetchGameDetails(gameId: game.id) { error, game in
            if let game = game {
                self.gameViewModel.value = GameItemViewModel(game: game)
            }
        }
    }
}


