//
//  ViewController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import SVPullToRefresh
import Swiftools
import HelperKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var games: [GameItemViewModel] {
        viewModel.items.value
    }
    
    private var viewModel: GamesListViewModel!
    
    private var finished = false
    private var page     = 2
    
    static func create(with viewModel: GamesListViewModel) -> SearchViewController {
        let view = SearchViewController.instantiate()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DefaultGamesListViewModel()
        viewModel.viewDidLoad()
        bind(to: viewModel)

        tableViewSetup()
        setupSearchBar()
    }
    
    private func bind(to viewModel: GamesListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.query.observe(on: self) { [weak self] in self?.updateSearchQuery($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func showError(_ error: String) {
        Log("SHOW ERROR")

        guard !error.isEmpty else { return }
        Log(error)
    }
    
    private func updateSearchQuery(_ query: String) {
        Log("UPDATE SEARCH QUERY")
        searchController.searchBar.text = query
    }
    
    private func updateLoading(_ loading: MoviesListViewModelLoading?) {
        Log("UPDATE LOADING")

    }
    
    private func updateItems() {
        Log("UPDATE ITEMS")

        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDefaultNavBar()
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        searchBar(searchController.searchBar, textDidChange: "")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    
    private func tableViewSetup() {
        tableView.registerCell(GameCell.self)
        addLazyLoading()
    }
    
    @IBAction func didPressMyGamesButton(_ sender: UIBarButtonItem) {
         let details = MyGamesViewController.instantiate("MyGames")
         push(details)
    }
    
    private func addLazyLoading() {
        tableView.addInfiniteScrolling {
            self.tableView.infiniteScrollingView.activityIndicatorViewStyle = .medium
            
            self.tableView.infiniteScrollingView.stopAnimating()
            self.viewModel.didRequestNextPage()
        }
    }
}


//MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearch(query: searchText)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.cell(GameCell.self).setupGameInfo(games[indexPath.row])
    }
}


//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let details = GameDetailsController.instantiate("GameDetails")
//        details.game = games[indexPath.row]
//        push(details)
    }
}

