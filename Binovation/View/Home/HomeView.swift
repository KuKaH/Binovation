//
//  LibraryView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI
import Combine

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Binovation")
                    .font(.spaceGrotesk(size: 20))
                    .bold()
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("긴급 수거가 필요합니다.")
                            .font(.headline)
                            .foregroundStyle(.red)
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                    }
                    
                    ForEach(0..<6) { index in
                        EmergencyBinCardView(
                            floor: "도서관 \(5 - index)층",
                            percent: 100 - (index * 10),
                            message: index == 0 ? "지금 수거하세요!" : "30분 내에\n수거 추천드려요!"
                            )
                    }
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(16)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
