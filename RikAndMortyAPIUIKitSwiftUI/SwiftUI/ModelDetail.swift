//
//  ModelDetail.swift
//  RikAndMortyAPIUIKitSwiftUI
//
//  Created by Валерия Дементьева on 17.08.2023.
//

import Foundation
import SwiftUI
class ObserveModelDetail: ObservableObject {
    @Published var info = ModelDetail.info

}

struct ModelDetail: Identifiable, Hashable {
    let name: String
    let region: String
    var id = UUID()
}

extension ModelDetail {
    static let info = [
        ModelDetail(name: "Москва", region: " область"),
        ModelDetail(name: "Санкт-Петербург", region: " область"),
        ModelDetail(name: "Мытищи", region: " область")
    ]
}
