//
//  ContentView.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("ochoice")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .imageScale(.large)
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundStyle(.tint)
                
                TextField("아이디 입력", text: $username)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
        

                SecureField("비밀번호 입력", text: $password)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                NavigationLink(destination: HomeView()) {
                    Text("로그인")
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("로그인")
        }
    }
}

#Preview {
    ContentView()
}
