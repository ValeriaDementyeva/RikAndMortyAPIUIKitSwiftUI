//
//  DetailScreenInfoController.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 17.08.2023.
//
import Foundation
import SwiftUI

struct DetailScreenInfoController: View {
    //MARK: - Properties
    @ObservedObject var dataModel = ObserveModelDetail()
    let columns = [GridItem(.flexible())]

    var body: some View {
        ScrollView(.vertical) {
            //MARK: - VStack with Image and 2 Text

            LazyVStack(alignment: .center) {
                Spacer(minLength: 16)
                Image("Rick")
                    .padding(.horizontal, 81.0)
                    .frame(width: 148, height: 148)
                    .cornerRadius(10)
                Spacer(minLength: 24)
                
                Text("Rick Sanchez")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.horizontal)
                Spacer(minLength: 8)
                
                Text("Alive")
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
                                ForEach(ModelDetail.info, id:\.id) { item in
                                    HStack(){
                                        Text(item.name)
                                            .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                            .font(.system(size: 16))
                                        
                                        Spacer()
                                        
                                        Text(item.region)
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                }
                            }
                            .padding()
                        }
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
                                VStack(spacing: 8){
                                    Text("Earth")
                                        .foregroundColor(Color(red: 0.769, green: 0.789, blue: 0.806))
                                    Text("Planet")
                                        .foregroundColor(.green)
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
        .background(Color(red: 0.013, green: 0.048, blue: 0.119))
    }//final body
}//final LazyVGride

//MARK: - Previews
struct DetailScreenInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenInfoController()
    }
}
