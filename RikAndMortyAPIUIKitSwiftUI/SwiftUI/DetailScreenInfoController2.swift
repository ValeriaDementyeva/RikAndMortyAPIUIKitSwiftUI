//
//  DetailScreenInfoController2.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 20.08.2023.
//

import Foundation
import SwiftUI

struct DetailScreenInfoController2: View {
    //MARK: - Properties
    let columns = [GridItem(.flexible())]
    let character: CharactersModelElement
    @State private var image: UIImage? = nil
    @State private var locationName: String? = nil
    @State private var locationType: String? = nil
    enum InfoPerson: String{
        case species = "Species"
        case type = "Type"
        case gender = "Gender"
    }

    var body: some View {
        let infoArray: [InfoPerson] = [.species, .type, .gender]
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
                    Section(header: Text("Info").font(.title3).foregroundColor(.white)) {
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
                                            if character.type == "" {
                                                Text("None")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16))
                                            } else {
                                                Text(character.type)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16))
                                            }
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
                        Section(header: Text("Origin").font(.title3).foregroundColor(.white)) {
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
                                                .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                            Text(locationType)
                                                .foregroundColor(.green)
                                        }
                                    }
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                            }
                        }//final section "Origin"
                        Section(header: Text("Episodes").font(.title3).foregroundColor(.white)) {
                            ForEach(ModelDetail.info, id:\.id) { item in
                                ZStack(){
                                    Rectangle()
                                        .cornerRadius(15)
                                        .frame(height: 86)
                                        .foregroundColor(Color(red: 0.149, green: 0.165, blue: 0.22))
                                    LazyVStack(spacing: 16){
                                        Text(item.name)
                                            .foregroundColor(.white)
                                            .font(.system(size: 17))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        HStack(){
                                            Text(item.region)
                                                .foregroundColor(.green)
                                                .font(.system(size: 13))
                                            Spacer()
                                            Text(item.name)
                                                .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                                .font(.system(size: 12))
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }//final section "Episodes"
                    }
                    .padding()
                }//final LazyVGride

            }//background scrollview
            .onAppear {
                APIManager2.shared.downloadImage(from: character.image) { downloadedImage in
                    DispatchQueue.main.async {
                        self.image = downloadedImage
                    }
                }
                APIManager2.shared.fetchCharactersModelLocation(from: character.location) { location in
                    DispatchQueue.main.async {
                        switch location {
                        case .success(let charactersModelLocation):
                            self.locationName = charactersModelLocation.name
                            self.locationType = charactersModelLocation.type
                            // Handle the rest of the data as needed
                        case .failure(let error):
                            print("Error fetching location data: \(error)")
                        }
                    }
                }
            }

        }   .background(Color(red: 0.013, green: 0.048, blue: 0.119))//final body
    }//final struct
}
//MARK: - Previews
struct DetailScreenInfo2_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCharacter = CharactersModelElement(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin:(Location(name: "jhkjhk", url: "")), location: (Location(name: "", url: "")), image: "", episode: [""], url: "", created: "")
        return DetailScreenInfoController2(character: sampleCharacter)
    }
}
