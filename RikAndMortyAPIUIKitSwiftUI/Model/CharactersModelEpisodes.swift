//
//  CharactersModelEpisodes.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 20.08.2023.
//

import Foundation
// MARK: - CharactersModelEpisodes
struct CharactersModelEpisodes: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
