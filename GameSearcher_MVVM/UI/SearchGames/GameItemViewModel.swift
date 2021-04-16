//
//  GameItemViewModel.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/15/21.
//  Copyright © 2021 Yulia. All rights reserved.
//

import Foundation
import RealmSwift

struct GameItemViewModel {
    let gameInfo: String?
    let released: String?
    let title: String
    let posterImage: String?
    let genres: List<String>
}

extension GameItemViewModel {
    
    init(game: GameItem) {
        self.title = game.name
        self.posterImage = game.mainImage
        self.genres = game.genres
        self.released = game.released
        self.gameInfo = game.gameInfo
    }
}
