//
//  SearchGameUseCase.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/15/21.
//  Copyright © 2021 Yulia. All rights reserved.
//

import Foundation

protocol SearchGamesUseCase {
    func execute(requestValue: SearchGamesUseCaseRequestValue,
                 completion: @escaping (Result<SearchResults, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchGamesUseCase: SearchGamesUseCase {

    private let gamesRepo: GamesRepository
    private let gamesQueriesRepository: GamesQueriesRepository

    init(gamesRepo: GamesRepository,
         gamesQueriesRepository: GamesQueriesRepository) {

        self.gamesRepo = gamesRepo
        self.gamesQueriesRepository = gamesQueriesRepository
    }

    func execute(requestValue: SearchGamesUseCaseRequestValue,
                 completion: @escaping (Result<SearchResults, Error>) -> Void) -> Cancellable? {

        return gamesRepo.fetchGamesList(query: requestValue.query,
                                        page: requestValue.page) { result in
            if case .success = result {
                self.gamesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }
            completion(result)
        }
    }
}

struct SearchGamesUseCaseRequestValue {
    let query: String
    let page: Int
}

