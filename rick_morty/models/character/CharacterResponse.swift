//
//  CharacterResponse.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation

struct CharacterResponse: Decodable {
    let info: Info
    let results: [Character]
}
