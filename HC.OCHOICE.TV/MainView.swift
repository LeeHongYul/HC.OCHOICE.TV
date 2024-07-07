import SwiftUI

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

struct MainBannerResponse: Codable {
    var categoryList: [CategoryBanner]
}

struct CategoryBanner: Codable, Identifiable {
    var id = UUID()
    var type: String
    var categoryItemList: [CategoryItemList]
    
    enum CodingKeys: String, CodingKey {
        case type
        case categoryItemList
    }
}

struct CategoryItemList: Codable, Identifiable {
    var id = UUID()
    var posterUrl: String
    
    enum CodingKeys: String, CodingKey {
        case posterUrl
    }
}

struct MainView: View {
    @State private var results = [Result]()
    @State var bannerResults: [CategoryBanner] = []
    @State var items: [String] = ["영화","방송","해외드라마","키즈/애니","다큐","라이프","O-FAST"]
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(0..<items.count, id: \.self) { index in
                            CardView(title: self.$items[index])
                        }
                    }
                }
                .padding()
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(bannerResults) { banner in
                            if banner.type == "mainBanner" {
                                ForEach(banner.categoryItemList) { item in
                                    Button(action: {
                                        // 버튼을 눌렀을 때 수행할 동작을 여기에 추가합니다.
                                        // 예: 특정 URL로 이동하거나 상세 화면으로 네비게이션하는 등의 동작
                                    }) {
                                        AsyncImage(url: URL(string: item.posterUrl)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 400, height: 400)
                                                .cornerRadius(30)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 400, height: 400)
                                        }
                                        .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 적용
                                    }
                                    .buttonStyle(PlainButtonStyle()) // LazyHStack 안의 버튼에도 적용하기 위해 추가
                                }
                            }
                        }
                    }
                    .padding() // 내용 주변에 여백을 추가합니다.
                    .frame(maxWidth: .infinity) // ScrollView가 가능한 최대 너비를 채우도록 설정합니다.
                    .scrollTargetLayout() // SwiftUI에서 사용할 수 있는 ScrollView 확장입니다. 필요에 따라 제거해도 됩니다.
                }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(results, id: \.id) { result in
                                HStack {
                                    Button(action: {
                                        // 버튼을 눌렀을 때 수행할 동작을 여기에 추가합니다.
                                        // 예: 특정 URL로 이동하거나 상세 화면으로 네비게이션하는 등의 동작
                                    }) {
                                        AsyncImage(url: URL(string: result.logoAccessUrl)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                            } else if phase.error != nil {
                                                Color.red.frame(width: 50, height: 50)
                                            } else {
                                                ProgressView()
                                                    .frame(width: 50, height: 50)
                                            }
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text(result.name)
                                            .font(.system(size: 50, design: .rounded))
                                        Text(result.description)
                                            .font(.system(size: 40, design: .rounded))
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .padding()
                    .navigationTitle("Channels")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                    }
                    .task {
                        await fetchData()
                        await fetchBannerData()
                    }
                }
            }
        }
        
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
            guard let url = URL(string: "https://prod-mbs.ochoice.co.kr/mbs/mainCategoryList?terminalKey=1FB765907D618A6E41A5DFFDEB2892A2&includeRrated=true") else {
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
                    self.bannerResults = decodedResponse.categoryList
                    print("Updated Banner results: \(self.bannerResults)")
                } catch {
                    print("Decoding Banner error: \(error)")
                }
            } catch {
                print("Invalid Banner data: \(error)")
            }
        }
    }
    
    
