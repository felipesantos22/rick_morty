//
//  EpisodeRespose.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation

struct EpisodeResponse: Decodable {
    let info: Info
    let results: [Episode]
}
