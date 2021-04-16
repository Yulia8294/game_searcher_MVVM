//
//  MoviesRepositoryInterfaces.swift
//  ExampleMVVM
//
//  Created by Yulia Novikova on 4/15/21.
//  Copyright © 2021 Yulia. All rights reserved.
//

import Foundation

protocol GamesRepository {
    
    @discardableResult
    func fetchGamesList(query: String, page: Int,
                         completion: @escaping (Result<SearchResults, Error>) -> Void) -> Cancellable?
}
