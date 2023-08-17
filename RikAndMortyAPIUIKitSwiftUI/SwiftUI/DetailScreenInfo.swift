//
//  DetailScreenInfo.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 17.08.2023.
//
import Foundation
import SwiftUI

struct DetailScreenInfo: View {
    var body: some View {
        
        let columns = [GridItem(.flexible())]
        
        ScrollView(.vertical) {
            LazyVStack(alignment: .center, spacing: 20) {
                Spacer(minLength: 20)
                Image("Rick")
                    .padding(.horizontal, 81.0)
                    .frame(width: 148, height: 148)
                    .cornerRadius(10)
                Text("Rick Sanchez")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.horizontal)
                Text("Alive")
                    .font(.system(size: 16))
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.horizontal)
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                    Section(header: Text("Info").font(.title3).foregroundColor(.white)) {
                        ZStack(){
                            Rectangle()
                                .cornerRadius(20)
                                .frame(height: 120)
                                .foregroundColor(Color(red: 0.15, green: 0.165, blue: 0.22))
                            VStack(){
                                ForEach(ModelDetail.info, id:\.id) { item in
                                    LazyHStack(){
                                        Text(item.name)
                                            .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                            .font(.system(size: 16))
                                        
                                        Text(item.region)
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                }
                            }
                        }
                    }
                    Section(header: Text("Origin").font(.title3).foregroundColor(.white)) {
                        ZStack(){
                            Rectangle()
                                .cornerRadius(20)
                                .frame(height: 80)
                                .foregroundColor(Color(red: 0.149, green: 0.165, blue: 0.22))
                            LazyHStack(){
                                ZStack(){
                                    Rectangle()
                                        .cornerRadius(20)
                                        .foregroundColor(Color(red: 0.095, green: 0.11, blue: 0.165))
                                        .frame(width: 64, height: 64)
                                    Image("Planet")
                                        .frame(width: 24, height: 24)
                                }
                                VStack(){
                                    Text("Earth")
                                        .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                    Text("Planet")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    Section(header: Text("Episodes").font(.title3).foregroundColor(.white)) {
                        ForEach(ModelDetail.info, id:\.id) { item in
                            ZStack(){
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(height: 86)
                                    .foregroundColor(Color(red: 0.149, green: 0.165, blue: 0.22))
                                LazyVStack(){
                                    Text(item.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17))
                                    HStack(){
                                        Text(item.region)
                                            .foregroundColor(.green)
                                            .font(.system(size: 13))
                                        Text(item.name)
                                            .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                            .font(.system(size: 12))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color(red: 0.013, green: 0.048, blue: 0.119))
    }
}

struct DetailScreenInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenInfo()
    }
}
