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
            Button {
                
            } label: {
                Text(title)
            }
        }
        .shadow(color: Color.black.opacity(0.2),radius: 5, x: 0, y: 0)
    }
}

