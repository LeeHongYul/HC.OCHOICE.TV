//
//  ApiError.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 7/3/24.
//

import Foundation

enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
