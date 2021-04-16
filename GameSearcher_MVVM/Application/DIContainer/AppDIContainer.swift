//
//  AppDIContainer.swift
//  GameSearcher_MVVM
//
//  Created by Yulia Novikova on 4/16/21.
//

import Foundation

final class AppDIContainer {
    
    func makeSearchGameSceneDIContainer() -> SearchGameDIContainer {
        let dependencies = SearchGameDIContainer.Dependencies(apiDataTransferService: "test", imageDataTransferService: "test")
        return SearchGameDIContainer(dependencies: dependencies)
    }
}
