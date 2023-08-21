//
//  DetailScreenInfoController.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 20.08.2023.
//

import Foundation
import SwiftUI

struct DetailScreenInfoController: View {
    //MARK: - Properties
    let columns = [GridItem(.flexible())]
    let character: CharactersModelElement
    @State private var image: UIImage? = nil
    @State private var locationName: String? = nil
    @State private var locationType: String? = nil
    @State private var episodes: [CharactersModelEpisodes] = []
    @State private var isLoading: Bool = true
    
    func formatEpisode(_ episode: String) -> String {
        let components = episode.split(separator: "E")
        if components.count == 2,
           let seasonNumber = Int(components[0].dropFirst(1)),
           let episodeNumber = Int(components[1]) {
            return "Episode: \(episodeNumber), Season: \(seasonNumber)"
        }
        return episode
    }
    
    enum InfoPerson: String{
        case species = "Species"
        case type = "Type"
        case gender = "Gender"
    }
    
    var body: some View {
        //MARK: - Loader
        let infoArray: [InfoPerson] = [.species, .type, .gender]
        ZStack(){
            Color(red: 0.013, green: 0.048, blue: 0.119).edgesIgnoringSafeArea(.all)
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
            } else {
                ScrollView(.vertical) {
                    //MARK: - VStack with Image and 2 Text
                    LazyVStack(alignment: .center) {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 148, height: 148)
                                .cornerRadius(10)
                        }
                        Spacer(minLength: 24)
                        
                        Text(character.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .padding(.horizontal)
                        Spacer(minLength: 8)
                        
                        Text(character.status)
                            .font(.system(size: 16))
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .padding(.horizontal)
                        Spacer(minLength: 24)
                        
                        //MARK: - VGrid with 3 sections
                        LazyVGrid(columns: columns, alignment: .leading) {
                            Section(header: Text("Info").font(.system(size: 17)).foregroundColor(.white)) {
                                ZStack(){
                                    Rectangle()
                                        .cornerRadius(15)
                                        .frame(height: 120)
                                        .foregroundColor(Color(red: 0.15, green: 0.165, blue: 0.22))
                                    
                                    VStack(spacing: 16){
                                        ForEach(infoArray, id:\.self){ item in
                                            HStack(){
                                                Text(item.rawValue)
                                                    .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                                    .font(.system(size: 16))
                                                
                                                Spacer()
                                                switch item {
                                                case .species:
                                                    Text(character.species)
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 16))
                                                case .type:
                                                    Text(character.type == "" ? "None" : character.type)
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 16))
                                                    
                                                case .gender:
                                                    Text(character.gender)
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 16))
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                }//final section "Info"
                                Section(header: Text("Origin").font(.system(size: 17)).foregroundColor(.white).padding(.top, 15)) {
                                    ZStack(){
                                        Rectangle()
                                            .cornerRadius(15)
                                            .frame(height: 80)
                                            .foregroundColor(Color(red: 0.149, green: 0.165, blue: 0.22))
                                        HStack(){
                                            ZStack(){
                                                Rectangle()
                                                    .cornerRadius(20)
                                                    .foregroundColor(Color(red: 0.095, green: 0.11, blue: 0.165))
                                                    .frame(width: 64, height: 64)
                                                
                                                Image("Planet")
                                                    .frame(width: 24, height: 24)
                                            }
                                            VStack(alignment: .leading, spacing: 8){
                                                if let locationName = locationName, let locationType = locationType {
                                                    Text(locationName)
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 16))
                                                    Text(locationType)
                                                        .font(.system(size: 13))
                                                        .foregroundColor(.green)
                                                }
                                            }
                                            
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(8)
                                    }
                                }//final section "Origin"
                                Section(header: Text("Episodes").font(.system(size: 17)).foregroundColor(.white).padding(.top, 15)) {
                                    ForEach(episodes, id: \.id) { item in
                                        ZStack(){
                                            Rectangle()
                                                .cornerRadius(15)
                                                .frame(height: 86)
                                                .foregroundColor(Color(red: 0.149, green: 0.165, blue: 0.22))
                                            
                                            LazyVStack(spacing: 20){
                                                
                                                Text(item.name)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                HStack(){
                                                    Text(formatEpisode(item.episode))
                                                        .foregroundColor(.green)
                                                        .font(.system(size: 13))
                                                    Spacer()
                                                    Text(item.airDate)
                                                        .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                                        .font(.system(size: 12))
                                                }
                                            }.padding()
                                        } .padding(.bottom, 10)
                                    }
                                }
                                
                            }//final section "Episodes"
                        }
                        .padding([.trailing, .leading], 15)
                    }//final LazyVGride
                    
                }}}//background scrollview
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //проверка loader, задержка подгрузки данных на 1 сек.)
                isLoading = false
                APIManager.shared.downloadImage(from: character.image) { downloadedImage in
                    DispatchQueue.main.async {
                        self.image = downloadedImage
                    }
                }
                APIManager.shared.downloadCharactersModelLocation(from: character.location) { location in
                    DispatchQueue.main.async {
                        switch location {
                        case .success(let charactersModelLocation):
                            self.locationName = charactersModelLocation.name
                            self.locationType = charactersModelLocation.type
                        case .failure(let error):
                            print("Error fetching location data: \(error)")
                        }
                    }
                }
                APIManager.shared.downloadEpisodes(from: character.episode) {  fetchedEpisodes, error in
                    DispatchQueue.main.async {
                        if let fetchedEpisodes = fetchedEpisodes {
                            episodes = fetchedEpisodes
                        }
                    }
                }
            }
        }
        .background(Color(red: 0.013, green: 0.048, blue: 0.119))
    }//final body
}//final struct
//MARK: - Previews
struct DetailScreenInfo2_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCharacter = CharactersModelElement(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin:(Location(name: "jhkjhk", url: "")), location: (Location(name: "", url: "")), image: "", episode: [""], url: "", created: "")
        return DetailScreenInfoController(character: sampleCharacter)
    }
}
