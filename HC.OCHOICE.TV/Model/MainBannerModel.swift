//
//  MainBannerModel.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 7/8/24.
//

import Foundation

struct MainBannerResponse: Codable {
    var categoryList: [CategoryBanner]
}

struct CategoryBanner: Codable, Identifiable {
    var id = UUID()
    var type: String
    var title: String
    var categoryItemList: [CategoryItemList]
    
    enum CodingKeys: String, CodingKey {
        case type
        case title
        case categoryItemList
    }
}

struct CategoryItemList: Codable, Identifiable {
    var id = UUID()
    var posterUrl: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterUrl
    }
}
