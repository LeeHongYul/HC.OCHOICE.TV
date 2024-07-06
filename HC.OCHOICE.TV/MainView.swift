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

struct MainView: View {
    @State private var results = [Result]()
    @State var items: [String] = ["영화","방송","해외드라마","키즈/애니","다큐","라이프","O-FAST"]
    
    var body: some View {
           NavigationView {
               
               VStack{
                   ScrollView(.horizontal) {
                       HStack(spacing: 15) {
                           ForEach(0..<items.count) {
                               CardView(title: self.$items[$0])
                           }
                       }
                   }
                   .padding()
                   ScrollView(.horizontal) {
                       HStack(spacing: 15) {
                           ForEach(results, id: \.id) { result in
                               HStack {
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
                                   VStack(alignment: .leading) {
                                       Text(result.name)
                                           .font(.headline)
                                       Text(result.description)
                                           .font(.subheadline)
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
}


