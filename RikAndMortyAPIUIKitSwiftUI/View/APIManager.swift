//
//  APIManager.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 20.08.2023.
//

import Foundation
import UIKit


class APIManager {
    static let shared = APIManager()
    
    let urlString = "https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21"
    
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
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
    
    func downloadCharactersModelLocation(from location: Location, completion: @escaping (Result<CharactersModelLocation, Error>) -> Void) {
        guard let url = URL(string: location.url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let locationModel = try decoder.decode(CharactersModelLocation.self, from: data)
                completion(.success(locationModel))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func downloadEpisodes(from URLs: [String], completion: @escaping ([CharactersModelEpisodes]?, Error?) -> Void) {
        var episodes: [CharactersModelEpisodes] = []
        let dispatchGroup = DispatchGroup()
        
        for url in URLs {
            dispatchGroup.enter()
            
            guard let url = URL(string: url) else {
                dispatchGroup.leave()
                continue
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer {
                    dispatchGroup.leave()
                }
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    let episode = try JSONDecoder().decode(CharactersModelEpisodes.self, from: data)
                    episodes.append(episode)
                } catch {
                    completion(nil, error)
                }
            }.resume()
        }
        dispatchGroup.notify(queue: .main) {
            completion(episodes, nil)
        }
    }
}
