//
//  HomeView.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 7/6/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            TabView {
                MainView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("홈")
                    }
                
                WatchHistoryView()
                    .tabItem {
                        Image(systemName: "clock")
                        Text("시청내역")
                    }
                
                VODView()
                    .tabItem {
                        Image(systemName: "film")
                        Text("VOD")
                    }
                
                MyPageView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("마이페이지")
                    }
            }
    }
}

