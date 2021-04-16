//
//  MoviesQueriesRepositoryInterface.swift
//  ExampleMVVM
//
//  Created by Yulia Novikova on 4/15/21.
//  Copyright © 2021 Yulia. All rights reserved.

import Foundation

protocol GamesQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[String], Error>) -> Void)
    func saveRecentQuery(query: String, completion: @escaping (Result<String, Error>) -> Void)
}
