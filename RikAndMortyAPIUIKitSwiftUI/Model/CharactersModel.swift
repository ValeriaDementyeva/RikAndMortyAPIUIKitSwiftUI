//
//  CharactersModel.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 18.08.2023.
//

import Foundation

struct CharactersModel: Hashable {
    var image: String
    var mane: String
}

extension CharactersModel {
    static let info = [
        CharactersModel(image: "Rick", mane: "Rick Sanchaz"),
        CharactersModel(image: "Rick", mane: "KJKJKJK"),
        CharactersModel(image: "Rick", mane: "QQQQQQQQ"),
        CharactersModel(image: "Rick", mane: "TTTTTTTTTT"),
        CharactersModel(image: "Rick", mane: "IIIIIIOOOG hk"),
        CharactersModel(image: "Rick", mane: "VHGHF FGf"),
        CharactersModel(image: "Rick", mane: "kjfoift fh"),
        CharactersModel(image: "Rick", mane: "jfn jfh sl"),
    ]
}
