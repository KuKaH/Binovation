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
                    .font(.madimiOne)
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
                    
                    ForEach(0..<3) { index in
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
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("최적 동선을 추천드립니다!")
                            .font(.headline)
                            .foregroundStyle(Color.blue)
                        Spacer()
                        Image(systemName: "figure.walk")
                            .foregroundStyle(.blue)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("추천 동선")
                                .bold()
                            Spacer()
                            Text("사회과학관 -> 도서관 -> 사이버관")
                        }
                        
                        Text("예상 소요시간: 30분")
                            .font(.spaceGrotest)
                        Text("처리해야 할 쓰레기통 개수: 4개")
                            .font(.caveat)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("세부사항").bold()
                            Text("사회과학관 5층 -> 4층 -> 3층")
                            Text("사회과학관 5층 -> 1층")
                            Text("사이버관 3층 -> 2층")
                        }
                    }
                    .font(.subheadline)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.bottom, 80)
        }
    }
}

#Preview {
    HomeView()
}
