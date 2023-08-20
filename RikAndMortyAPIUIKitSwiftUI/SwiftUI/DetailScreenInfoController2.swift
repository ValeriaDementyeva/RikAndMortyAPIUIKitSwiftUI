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
    
    let character: CharactersModelElement
    
    var body: some View {
        ScrollView(.vertical) {
            //MARK: - VStack with Image and 2 Text
            
            LazyVStack(alignment: .center) {
                
                Image("Rick")
                    .padding(.horizontal, 81.0)
                    .frame(width: 148, height: 148)
                    .cornerRadius(10)
                
                
                Text(character.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.horizontal)
                
                
                
                Text(character.status)
                    .font(.system(size: 16))
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.horizontal)
                Spacer(minLength: 24)
                
                
            
            }
            .background(Color(red: 0.013, green: 0.048, blue: 0.119))
        }//final body
    }//final struct
}
//MARK: - Previews
struct DetailScreenInfo2_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCharacter = CharactersModelElement(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin:(Location(name: "", url: "")), location: (Location(name: "", url: "")), image: "", episode: [""], url: "", created: "")
        return DetailScreenInfoController2(character: sampleCharacter)
    }
}
