//
//  FastChannelModel.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 7/8/24.
//

import Foundation

struct Response: Codable {
    var channels: [Result]
}

struct Result: Codable, Identifiable {
    var id = UUID()
    var name: String
    var state: String
    var logoAccessUrl: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case name, state, logoAccessUrl, description
    }
}
