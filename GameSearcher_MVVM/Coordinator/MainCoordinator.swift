//
//  MainCoordinator.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/16/21.
//

import UIKit

final class MainCoordinator {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let searchSceneDIContainer = appDIContainer.makeSearchGameSceneDIContainer()
        let coordinator = searchSceneDIContainer.makeGameSearchCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
