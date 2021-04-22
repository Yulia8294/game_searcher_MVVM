//
//  MyGamesViewModel.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/21/21.
//

import Foundation
import RealmSwift

struct MyGamesViewModelActions {
    let showGameDetails: (GameItem) -> Void
}

protocol MyGamesViewModel: MyGamesViewModelInput, MyGamesViewModelOutput { }

protocol MyGamesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at IndexPath: IndexPath)
    func didChangePresentationType()
}

protocol MyGamesViewModelOutput {
    var screenTitle: String { get }
    var items: Observable<[[GameItemViewModel]]> { get }
    var type: Observable<PresentationType> { get }
}

final class DefaultMyGamesViewModel: MyGamesViewModel {

    private var actions: MyGamesViewModelActions?
    
    private var games: Results<GameItem> {
        RealmService.shared.objects(GameItem.self)
    }
    private var groupedGames: [[GameItem]] = [[]]


    init(actions: MyGamesViewModelActions) {
        self.actions = actions
    }
    
    var screenTitle: String = "My Games"
    
    var items: Observable<[[GameItemViewModel]]> = Observable([])
    var type: Observable<PresentationType> = Observable(.all)

    func viewDidLoad() {
        assembleGroupedGames()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
    
    func didChangePresentationType() {
        
    }
    
//MARK: - Private
    
    private func assembleGroupedGames() {
        let groupedUsers = Dictionary(grouping: games) { $0.releaseYear }
        let sortedKeys = groupedUsers.keys.sorted { $0 > $1 }
        sortedKeys.forEach { (key) in
            if let values = groupedUsers[key] {
                groupedGames.append(values)
                items.value.append(values.map{ GameItemViewModel(game: $0)})
            }
        }
    }
}
