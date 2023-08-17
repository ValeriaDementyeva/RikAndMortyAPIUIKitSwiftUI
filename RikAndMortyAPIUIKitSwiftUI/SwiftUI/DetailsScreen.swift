//
//  DetailsScreen.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 17.08.2023.
//

import SwiftUI


struct DetailsScreen: View {

        struct Sea: Hashable, Identifiable {
            let name: String
            let id = UUID()
        }
        
        
        struct OceanRegion: Identifiable {
            let name: String
            let seas: [Sea]
            let id = UUID()
        }
        
        
        private let oceanRegions: [OceanRegion] = [
            OceanRegion(name: "Pacific",
                        seas: [Sea(name: "Australasian Mediterranean"),
                               Sea(name: "Philippine"),
                               Sea(name: "Coral"),
                               Sea(name: "South China")]),
            OceanRegion(name: "Pacific",
                        seas: [Sea(name: "Australasian Mediterranean"),
                               Sea(name: "Philippine"),
                               Sea(name: "Coral"),
                               Sea(name: "South China")]),
            OceanRegion(name: "Pacific",
                        seas: [Sea(name: "Australasian Mediterranean"),
                               Sea(name: "Philippine"),
                               Sea(name: "Coral"),
                               Sea(name: "South China")]),
            OceanRegion(name: "Atlantic",
                        seas: [Sea(name: "American Mediterranean"),
                               Sea(name: "Sargasso"),
                               Sea(name: "Caribbean")]),
            OceanRegion(name: "Indian",
                        seas: [Sea(name: "Bay of Bengal")]),
            OceanRegion(name: "Southern",
                        seas: [Sea(name: "Weddell")]),
            OceanRegion(name: "Arctic",
                        seas: [Sea(name: "Greenland")])
        ]
        
        
        @State private var singleSelection: UUID?
        
        //    private var columns = [GridItem(.fixed(100), spacing: 16)]
        
    var body: some View {
            VStack(alignment: .center) {
                Spacer(minLength: 30)
                Image("Rick")
                    .padding(.horizontal, 81.0)
                    .frame(width: 148, height: 148)
                    .cornerRadius(10)
                Spacer(minLength: 20)
                Text("Rick Sanchez")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.horizontal)
                Spacer(minLength: 10)
                Text("Alive")
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.horizontal)

                List(selection: $singleSelection) {
                    ForEach(oceanRegions) { region in
                        Section(header: Text("Major \(region.name) Ocean Seas")) {
                            ForEach(region.seas) { sea in
                                Text(sea.name)
                            }
                        }
            }
        }
    }
            .background(Color(red: 0.013, green: 0.048, blue: 0.119))
        }
    }


struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}
