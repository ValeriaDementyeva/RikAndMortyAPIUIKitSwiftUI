//
//  APIManager.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 19.08.2023.
//

import Foundation

class APIManager {
    static let shared = APIManager()

    let urlString = "https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8"

    func getCharacters(completion: @escaping ([CharactersModelElement]) -> Void) {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let characters = try JSONDecoder().decode([CharactersModelElement].self, from: data)
                print("OK")
                completion(characters)
            } catch {
                print("Error decoding: \(error)")
            }
        }
        task.resume()
    }
}
