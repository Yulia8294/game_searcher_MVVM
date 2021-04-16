//
//  PosterImagesRepositoryInterface.swift
//  ExampleMVVM
//
//  Created by Yulia Novikova on 4/15/21.
//  Copyright © 2021 Yulia. All rights reserved.

import Foundation

protocol PosterImagesRepository {
    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
