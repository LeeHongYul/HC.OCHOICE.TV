////
////  ContentViewModel.swift
////  HC.OCHOICE.TV
////
////  Created by homechoic on 7/3/24.
////
//
//import Foundation
//import Combine
//
//class ContentViewModel: ObservableObject {
//    @State private var content: [ContentModel] = []
//  
//
//    private var cancellables = Set<AnyCancellable>()
//    
//    func fetchData() async {
//        isLoading = true
//        errorMessage = nil
//        
//        guard let url = URL(string: "https://z58gf7c0de.execute-api.ap-northeast-2.amazonaws.com/homechoice-prod/channels") else{
//            return
//        }
//        
//        do {
//              let (data, meta) = try await URLSession.shared.data(from: url)
//              print(meta)
//              if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.content
//              }
//            } catch {
//              print("Invalid data")
//            }
//    }
//}
