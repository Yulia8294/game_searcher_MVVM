//
//  GameCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 12/15/19.
//  Copyright © 2019 Yulia. All rights reserved.
//

import UIKit
import Kingfisher

class GameCell: UITableViewCell {

    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameGenre: UILabel!
        

    func setupGameInfo(_ game: GameItemViewModel) -> Self {
        gameTitle.text = game.title
        gameGenre.text = game.genres.joined(separator: ", ")
        
        guard let image = game.posterImage else   { return self }
        guard let url = URL(string: image) else { return self }
        gameImageView.kf.indicatorType = .activity
        gameImageView.kf.setImage(with: url)
        
       return self
    }
}
