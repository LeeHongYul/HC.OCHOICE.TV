//
//  MyPageView.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 7/6/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("마이페이지 화면")
                    .font(.largeTitle)
                    .padding()
            }
            .navigationTitle("마이페이지")
        }
    }
}
