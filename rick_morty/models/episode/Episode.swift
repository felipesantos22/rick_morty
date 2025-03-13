//
//  Episode.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation


struct Episode : Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let created: String
}
