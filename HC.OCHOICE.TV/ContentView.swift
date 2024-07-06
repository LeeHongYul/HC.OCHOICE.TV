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
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                TextField("아이디 입력", text: $username)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
        

                SecureField("비밀번호 입력", text: $password)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                NavigationLink(destination: MainView()) {
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
