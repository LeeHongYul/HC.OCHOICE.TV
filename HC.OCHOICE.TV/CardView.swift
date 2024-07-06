//
//  CardView.swift
//  HC.OCHOICE.TV
//
//  Created by homechoic on 7/6/24.
//

import SwiftUI

struct CardView: View {
    @Binding var title: String
    
    var body: some View {
        ZStack {
            Color.black
                .cornerRadius(30)
            Text(title)
                .padding()
        }
        .frame(height: 50)
        .shadow(color: Color.black.opacity(0.2),radius: 5, x: 0, y: 0)
    }
}

