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
    
    private var detailsViewModel: GameDetailsViewModel!
    
    static func create(with detailsViewModel: GameDetailsViewModel, gameViewModel: GameItemViewModel) -> GameDetailsController {
        let view = GameDetailsController.instantiate("GameDetails")
        view.detailsViewModel = detailsViewModel
        return view
    }
    
//    private var storedGame: GameItem? {
//        RealmService.shared.object(GameItem.self, key: game.id)
//    }
//

    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameInfoTableView.setup(with: detailsViewModel.gameViewModel.value)
     //   trailersDataSource.set(trailersCollectionView, [])
        screenshotsDataSource.set(screenshotsCollectionView, collectionPageControl)
        similarGamesDataSource.set(collectionView: similarCollectionView, data: [], presentingVC: self)
    //    setupButtonsState()
        setupGame()
        bind(to: detailsViewModel)
        detailsViewModel.viewDidLoad()
      //  getSimilarGames()
     //   getTrailers()
    }
    
    private func bind(to viewModel: GameDetailsViewModel) {
        detailsViewModel.similarGames.observe(on: self) { [weak self] in self?.onSimilarGamesChanged($0) }
        detailsViewModel.gameViewModel.observe(on: self) { [weak self] in self?.onGameDetailsChanged($0) }
        detailsViewModel.screenshots.observe(on: self) { [weak self] in self?.onScreenshotsChanged($0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGradientNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      //  handleSaveButtonsState()
    }
    
//MARK: - Setup
    

    
    private func setupGame() {
        title = detailsViewModel.title
    }
    
//    private func setupButtonsState() {
//        guard let game = storedGame else { return }
//        addToListButton.isActive = game.isFavourite
//        addToPlayedButton.isActive = game.played
//    }
//
//    private func handleSaveButtonsState() {
//        if let game = storedGame {
//            (!addToListButton.isActive && !addToPlayedButton.isActive) ? RealmService.shared.delete(game) : RealmService.shared.append(game)
//        }
//    }
    
//MARK: - ViewModel input
    
    private func onScreenshotsChanged(_ screenshots: [String]) {
        screenshotsDataSource.screenshots = screenshots
    }
    
    private func onGameDetailsChanged(_ game: GameItemViewModel) {
        gameInfoTableView.setup(with: game)
    }
    
    private func onSimilarGamesChanged(_ games: [GameItem]) {
        similarGamesDataSource.data = games
    }
    
    private func onTrailersChanged(_ trailers: [Trailer]) {
        trailersDataSource.trailers = trailers
    }

        
//MARK: - @IBActions
    
    @IBAction func didPressSaveGameButton(_ sender: TwoStateButton) {
        detailsViewModel.addedToFavourites()
    }
    
    @IBAction func didPressAddToPlayedButton(_ sender: TwoStateButton) {
        detailsViewModel.addedToPlayed()
    }
}


