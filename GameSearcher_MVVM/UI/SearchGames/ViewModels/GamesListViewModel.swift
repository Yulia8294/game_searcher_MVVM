//
//  GamesListViewModel.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/15/21.
//  Copyright © 2021 Yulia. All rights reserved.
//

import Foundation
import Swiftools

enum MoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

struct GamesListViewModelActions {
    
    let showGameDetails: (GameItem) -> Void
}

protocol GamesListViewModelInput {
    func viewDidLoad()
    func didRequestNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func didSelectItem(at index: Int)
}

protocol GamesListViewModelOutout {
    var items: Observable<[GameItemViewModel]> { get }
    var loading: Observable<MoviesListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol GamesListViewModel: GamesListViewModelInput, GamesListViewModelOutout {}

final class DefaultGamesListViewModel: GamesListViewModel {
    
    private var searhGamesUseCase: SearchGamesUseCase?
    private var actions: GamesListViewModelActions?
    
    var currentPage: Int = 1
  //  var totalPageCount: Int = 1
    var hasMorePages: Bool = true
    var nextPage: Int { currentPage + 1 }
    
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }

    // MARK: - OUTPUT

    let items: Observable<[GameItemViewModel]> = Observable([])
    let loading: Observable<MoviesListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    
    var isEmpty: Bool { return items.value.isEmpty }
    
    let screenTitle = NSLocalizedString("Game searcher", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search games", comment: "")
    
    // MARK: - Init
    
    init() { }

    //MARK: - Private
    
    private func appendResults(_ results: [GameItem]) {
        currentPage += 1
        items.value += results.map(GameItemViewModel.init)
    }
    
    private func resetPages() {
        currentPage = 1
  //      totalPageCount = 1
    //    pages.removeAll()
    //    items.value.removeAll()
    }
    
    private func handle(error: Error) {
        LogError("Failed loading games")
    }
    
    private func update(query: String) {
        resetPages()
        load(query: query, loading: .fullScreen)
    }
    
    private func load(query: String, loading: MoviesListViewModelLoading) {
        hasMorePages = true
        self.loading.value = loading
        self.query.value = query
        
        APIService.fetchAllGames(page: currentPage, searchText: query) { error, games in
            guard let games = games else { return }
            self.items.value = games.map { GameItemViewModel(game: $0)}
        }
    }
    
    
//MARK: - Bindings
    
    func viewDidLoad() { }
    
    func didRequestNextPage() {
        guard hasMorePages else {
            Log("No more pages")
            return
        }
        
        APIService.fetchAllGames(page: nextPage, searchText: query.value) { error, games in
            guard let games = games else {
                self.hasMorePages = false
                return
            }
            self.appendResults(games)
        }
        
    }
    
    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(query: query)
    }
    
    func didCancelSearch() {
        moviesLoadTask?.cancel()
    }
    
    func didSelectItem(at index: Int) {
       // actions?.showGameDetails(pages.games[index])
    }
    
}

private extension Array where Element == SearchResults {
    var games: [GameItem] { flatMap { $0.results } }
}