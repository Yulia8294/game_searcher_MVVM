//
//  SimilarGamesCell.swift
//  GameSearcher
//
//  Created by Yulia Novikova on 4/3/20.
//  Copyright © 2020 Yulia. All rights reserved.
//

import UIKit

class SimilarGamesCell: UICollectionViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    func setupGame(_ game: GameItemViewModel) -> Self {
        gameTitleLabel.text = game.title
        
        guard let image = game.posterImage,
              let url = URL(string: image) else { return self }
        
        gameImageView.kf.indicatorType = .activity
        gameImageView.kf.setImage(with: url)
        return self
    }

}
