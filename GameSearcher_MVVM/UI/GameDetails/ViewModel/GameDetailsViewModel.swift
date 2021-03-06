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
    var similarGames: Observable<[GameItemViewModel]> { get }
    var gameViewModel: Observable<GameItemViewModel> { get }
    var trailers: Observable<[Trailer]> { get }
    var isPlayed: Observable<Bool> { get }
    var isAddedToFavourite: Observable<Bool> { get }
}

protocol GameDetailsViewModel: GameDetailsViewModelInput, GameDetailsViewModelOutput {}

final class DefaultGameDetailsViewModel: GameDetailsViewModel {
   
    // MARK: - OUTPUT

    var title: String
    var mainImage: Observable<String?> = Observable(nil)
    var screenshots: Observable<[String]> = Observable([])
    var similarGames: Observable<[GameItemViewModel]> = Observable([])
    var trailers: Observable<[Trailer]> = Observable([])
    var gameViewModel: Observable<GameItemViewModel>
    var isPlayed: Observable<Bool> = Observable(false)
    var isAddedToFavourite: Observable<Bool> = Observable(false)

    private var game: GameItem {
        didSet {
            if let game = RealmService.shared.object(GameItem.self, key: game.id) {
                self.game = game
            }
        }
    }
    
    init(game: GameItem) {
        self.game = game
        isPlayed.value = game.played
        isAddedToFavourite.value = game.isFavourite
        title = game.name
        mainImage.value = game.mainImage
        gameViewModel = Observable(GameItemViewModel(game: game))
    }
}

// MARK: - INPUT. View event methods

extension DefaultGameDetailsViewModel {
    
    func viewDidLoad() {
        screenshots.value.insertIfNotNil(mainImage.value, at: 0)
        fetchDetails()
        getSimilarGames()
        fetchScreenshots()
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
                var screenshots = screens.map { $0.image }
                screenshots.insertIfNotNil(mainImage.value, at: 0)
                self.screenshots.value = screenshots
            }
        }
    }
    
    private func getTrailers() {
        APIService.getGameTrailers(game.id) { error, trailers in
            if let trailers = trailers {
                self.trailers.value = trailers
            }
        }
    }
    
    private func getSimilarGames() {
        APIService.getSimilarGames(gameId: game.id) { error, games in
            if let games = games {
                self.similarGames.value = games.map { GameItemViewModel(game: $0) }
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


