//
//  SelectedCharacter.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 20.08.2023.
//

import Foundation
struct SelectedCharacter: Identifiable {
    let id = UUID()
    let character: CharactersModelElement
}
