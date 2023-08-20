//
//  APIManager2.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 20.08.2023.
//

import Foundation
class APIManager2 {
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
            

                for character in characters {
                    // Достаем данные из location
                    let locationName = character.location.name
                    let locationURL = character.location.url

                    // Достаем данные из url
                    if let url = URL(string: locationURL) {
                        if let data = try? Data(contentsOf: url) {
                            if let locationData = try? JSONDecoder().decode(CharactersModelLocation.self, from: data) {
                                let locationNameFromURL = locationData.name
                                let locationTypeFromURL = locationData.type

                                print("Location Name from URL: \(locationNameFromURL)")
                                print("Location Type from URL: \(locationTypeFromURL)")
                            }
                        }
                    }
                }

                completion(characters)
            } catch {
                print("Error decoding: \(error)")
            }
        }
        task.resume()
    }
}
