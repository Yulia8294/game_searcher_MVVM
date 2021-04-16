//
//  InfoTableView.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 5/10/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit
import Swiftools
import HelperKit

enum GameInfo: String, CaseIterable {
    case genre       = "Genre"
    case released    = "Released"
    case platforms   = "Platforms"
    case developer   = "Developer"
    case description = "Description"
}

class InfoTableView: DynamicTableView, UITableViewDelegate, UITableViewDataSource {
    
    private var gameViewModel: GameItemViewModel!
    
    func setup(with viewModel: GameItemViewModel) {
        self.gameViewModel = viewModel
        delegate = self
        dataSource = self
        registerCell(InfoCell.self)
        registerCell(DescriptionCell.self)
        rowHeight = UITableView.automaticDimension
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GameInfo.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(InfoCell.self)
        switch indexPath.row {
        case 0:
            return cell.setup(.genre, gameViewModel.genres.joined(separator: ", "))
        case 1:
            return cell.setup(.released, gameViewModel.released.anyString)
        case 2:
            return cell.setup(.platforms, gameViewModel.platforms.joined(separator: ", "))
        case 3:
            return cell.setup(.developer, "coming soon")
        case 4:
            return tableView.cell(DescriptionCell.self).setDelegate(self).setup(.description, gameViewModel.gameInfo.anyString.stripHTML ?? "")
        default:
            fatalError()
        }
    }
}

extension InfoTableView: DescriptionCellDelegate {
    
    func needUpdateCellHeight() {
        updateHeight()
    }
}


