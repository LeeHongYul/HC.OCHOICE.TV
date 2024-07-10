//
//  MainViewModel.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 7/8/24.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var results = [Result]()
    @Published var bannerResults: [CategoryBanner] = []

    func fetchData() async {
        guard let url = URL(string: "https://z58gf7c0de.execute-api.ap-northeast-2.amazonaws.com/homechoice-prod/channels") else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("T1JHLUpCdjkwN2lwUGR1TFaSYkdoanZwWVVCSFcwRkIxbTo2MTQ3MTkzN1haU2I2Yz==", forHTTPHeaderField: "Authorization")
        request.setValue("4WsXNBi6X9I2q0F02qaX4JtI", forHTTPHeaderField: "ProjectId")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(response)

            // 응답 데이터 디버깅
            if let json = String(data: data, encoding: .utf8) {
                print("Response JSON: \(json)")
            }

            // 디코딩 시 에러 메시지 출력
            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.results = decodedResponse.channels
                    print("Updated results: \(self.results)")
                }
            } catch {
                print("Decoding error: \(error)")
            }
        } catch {
            print("Invalid data: \(error)")
        }
    }

    func fetchBannerData() async {
        guard let url = URL(string: "https://dev-mbs.ochoice.co.kr/mbs/mainCategoryList?terminalKey=4464171DD06DEE911FBD3F2E19F2A5B&includeRrated=true") else {
            return
        }

        var request = URLRequest(url: url)
        // Uncomment and set the correct headers if needed
        // request.setValue("T1JHLUpCdjkwN2lwUGR1TFaSYkdoanZwWVVCSFcwRkIxbTo2MTQ3MTkzN1haU2I2Yz==", forHTTPHeaderField: "Authorization")
        // request.setValue("4WsXNBi6X9I2q0F02qaX4JtI", forHTTPHeaderField: "ProjectId")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(response)

            // Debug response data
            if let json = String(data: data, encoding: .utf8) {
                print("Response Banner JSON: \(json)")
            }

            // Decode JSON response
            do {
                let decodedResponse = try JSONDecoder().decode(MainBannerResponse.self, from: data)
                DispatchQueue.main.async {
                    self.bannerResults = decodedResponse.categoryList
                    print("Updated Banner results: \(self.bannerResults)")
                }
            } catch {
                print("Decoding Banner error: \(error)")
            }
        } catch {
            print("Invalid Banner data: \(error)")
        }
    }
}
