////
////  RequestAPI.swift
////  HC.OCHOICE.TV
////
////  Created by homechoic on 7/3/24.
////
//
//import Foundation
//
//
//class RequestAPI {
//    static let shared = RequestAPI()
//    private init() { }
//    
//    func fetchData() async throws ->  [ContentModel] {
//        
//        guard let url = URL(string: "https://z58gf7c0de.execute-api.ap-northeast-2.amazonaws.com/homechoice-prod/channels") else{
//            throw ApiError.invalidUrl("")
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw ApiError.invalidResponse
//        }
//        
//        guard httpResponse.statusCode == 200 else {
//            throw ApiError.failed(httpResponse.statusCode)
//        }
//        
//        let decoder = JSONDecoder()
//        let result = try decoder.decode(ContentModel.self, from: data)
//        
//        return [result]
//    }
//}
