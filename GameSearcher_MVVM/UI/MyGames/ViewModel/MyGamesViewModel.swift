//
//  MyGamesViewModel.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/21/21.
//

import Foundation

struct MyGamesViewModelActions {
    let showGameDetails: (GameItem) -> Void
}

protocol MyGamesViewModel: MyGamesViewModelInput, MyGamesViewModelOutput { }

protocol MyGamesViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
    
}

protocol MyGamesViewModelOutput {
    var screenTitle: String { get }
    var items: Observable<[GameItemViewModel]> { get }
}




final class DefaultMyGamesViewModel: MyGamesViewModel {
    
    private var actions: MyGamesViewModelActions?

    init(actions: MyGamesViewModelActions) {
        self.actions = actions
    }
    
    var screenTitle: String = ""
    var items: Observable<[GameItemViewModel]> = Observable([])
    
    
    func viewDidLoad() {
        
    }
    
    func didSelectItem(at index: Int) {
    
    }
    
  
    
    
    
}
