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
    var description: Observable<String?> { get }
    var screenshots: Observable<[String]> { get }
}

protocol GameDetailsViewModel: GameDetailsViewModelInput, GameDetailsViewModelOutput {}

final class DefaultGameDetailsViewModel: GameDetailsViewModel {
   
    // MARK: - OUTPUT

    var title: String
    var mainImage: Observable<String?> = Observable(nil)
    var description: Observable<String?> = Observable(nil)
    var screenshots: Observable<[String]> = Observable([])

    var game: GameItem
    
    init(game: GameItem) {
        self.game = game
        title = game.name
        mainImage.value = game.mainImage
    }
}

// MARK: - INPUT. View event methods

extension DefaultGameDetailsViewModel {
    
    func viewDidLoad() {
        
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
    
}


