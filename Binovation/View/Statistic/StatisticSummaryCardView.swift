//
//  StatisticSummaryCardView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct StatisticSummaryCardView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.black)
            
            Text(value)
                .font(.title2)
                .bold()
        }
        .frame(width: 100, height: 50)
        .padding()
        .background(Color(red: 230/255, green: 240/255, blue: 255/255))
        .cornerRadius(16)
    }
}

//#Preview {
//    StatisticSummaryCardView()
//}
