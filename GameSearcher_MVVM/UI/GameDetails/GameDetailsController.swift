//
//  GameDetailsController.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/27/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import RealmSwift
import AVFoundation
import AVKit
import HelperKit
import Swiftools

class GameDetailsController: UIViewController {
    
    @IBOutlet weak var collectionPageControl: PageIndicatorView!
    @IBOutlet weak var trailersCollectionView: UICollectionView!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var gameInfoTableView: InfoTableView!
    
    private let similarGamesDataSource = SimilarGamesDataSource()
    private let screenshotsDataSource  = ScreenshotsDataSource()
    private let trailersDataSource     = GameTrailersDataSource()
    
    @IBOutlet weak var addToPlayedButton: TwoStateButton!
    @IBOutlet weak var addToListButton: TwoStateButton!
    
    private var viewModel: GameDetailsViewModel!
    
    static func create(with viewModel: GameDetailsViewModel) -> GameDetailsController {
        let view = GameDetailsController.instantiate()
        view.viewModel = viewModel
        return view
    }
    
    private var storedGame: GameItem? {
        RealmService.shared.object(GameItem.self, key: game.id)
    }
    
    var game: GameItem! {
        didSet {
            if let game = RealmService.shared.object(GameItem.self, key: game.id) {
                self.game = game
            }
        }
    }
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameInfoTableView.setup(with: GameItemViewModel(game: game))
        Log(game.id)
        setupButtonsState()
        setupGame(game)
        getSimilarGames()
     //   getTrailers()
    }
    
    private func bind(to viewModel: GameDetailsViewModel) {
        //viewModel.description.observe(on: self) { [weak self] in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGradientNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        handleSaveButtonsState()
    }
    
//MARK: - Setup
    
    private func getTrailers() {
        APIService.getGameTrailers(game.id) { error, trailers in
            if let trailers = trailers {
                self.trailersDataSource.set(self.trailersCollectionView, trailers)
            }
        }
    }
    
    private func getSimilarGames() {
        APIService.getSimilarGames(1, game.id) { error, games in
            if let games = games {
                self.similarGamesDataSource.set(collectionView: self.similarCollectionView, data: games, presentingVC: self)
            }
        }
    }
    
    private func setupGame(_ game: GameItem) {
        title = game.name
        fetchDetails()
        fetchScreenshots()
    }
    
    private func setupButtonsState() {
        guard let game = storedGame else { return }
        addToListButton.isActive = game.isFavourite
        addToPlayedButton.isActive = game.played
    }
    
    private func handleSaveButtonsState() {
        if let game = storedGame {
            (!addToListButton.isActive && !addToPlayedButton.isActive) ? RealmService.shared.delete(game) : RealmService.shared.append(game)
        }
    }
    
//MARK: - Private methods
    
    private func fetchDetails() {
        APIService.fetchGameDetails(gameId: game.id) { error, game in
            if let game = game {
                self.game = game
                self.gameInfoTableView.setup(with: GameItemViewModel(game: game))
            }
        }
    }
    
    private func fetchScreenshots() {
            screenshotsDataSource.set(screenshotsCollectionView, collectionPageControl)
        
        if let image = game.mainImage {
            screenshotsDataSource.screenshots.append(image)
            screenshotsCollectionView.reloadData()
        }
        
        APIService.getScreenshots(game.slug) { [self] error, screenshots in
            if let screens = screenshots {
                screens.forEach { screenshotsDataSource.screenshots.append($0.image) }
                screenshotsCollectionView.reloadData()
            }
        }
    }
    
        
//MARK: - @IBActions
    
    @IBAction func didPressSaveGameButton(_ sender: TwoStateButton) {
        viewModel.addedToFavourites()
    }
    
    @IBAction func didPressAddToPlayedButton(_ sender: TwoStateButton) {
        viewModel.addedToPlayed()
    }
}


