import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State var items: [String] = ["영화","방송","해외드라마","키즈/애니","다큐","라이프","O-FAST"]
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<items.count, id: \.self) { index in
                            CardView(title: self.$items[index])
                        }
                    }
                }
                .padding()
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(viewModel.bannerResults) { banner in
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
                        ForEach(viewModel.results, id: \.id) { result in
                            Button(action: {
                                
                            }) {
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
                                            .font(.system(size: 50, design: .rounded))
                                        Text(result.description)
                                            .font(.system(size: 40, design: .rounded))
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                ScrollView(.vertical) {
                            ForEach(viewModel.bannerResults) { banner in
                                if banner.type == "asset" {
                                    VStack(alignment: .leading) {
                                        Text(banner.title)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .padding()
                                            .background(Color.black.opacity(0.7))
                                            .cornerRadius(10)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(banner.categoryItemList) { item in
                                                    Button(action: {
                                                        // 버튼을 눌렀을 때 수행할 동작을 여기에 추가합니다.
                                                    }) {
                                                        ZStack {
                                                            AsyncImage(url: URL(string: item.posterUrl)) { image in
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fill)
                                                                    .frame(width: 200, height: 300)
                                                                    .cornerRadius(15)
                                                            } placeholder: {
                                                                ProgressView()
                                                                    .frame(width: 200, height: 200)
                                                            }
                                                        }
                                                    }
                                                    .buttonStyle(PlainButtonStyle())
                                                }
                                            }
                                            .padding()
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
                    await viewModel.fetchData()
                    await viewModel.fetchBannerData()
                }
            }
        }
    }
}


