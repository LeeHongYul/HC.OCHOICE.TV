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
                HStack(spacing: 50) { // spacing을 0으로 설정하여 버튼들이 붙어 있게 함
                    Button {
                        
                    } label: {
                        Text("아이디 찾기")
                            .font(.system(size: 30)) // 폰트 크기를 작게 설정
                    }
                    .buttonStyle(PlainButtonStyle()) // 버튼의 기본 모양 제거

                    Button {
                        
                    } label: {
                        Text("비밀번호 찾기")
                            .font(.system(size: 30)) // 폰트 크기를 작게 설정
                    }
                    .buttonStyle(PlainButtonStyle()) // 버튼의 기본 모양 제거

                    Button {
                        
                    } label: {
                        Text("회원 가입")
                            .font(.system(size: 30)) // 폰트 크기를 작게 설정
                    }
                    .buttonStyle(PlainButtonStyle()) // 버튼의 기본 모양 제거
                }

                NavigationLink(destination: HomeView()) {
                    Text("로그인")
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
