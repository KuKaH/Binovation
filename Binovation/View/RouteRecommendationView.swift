//
//  RouteRecommendationView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct RouteRecommendationView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("동선 추천")
                    .font(.title)
                    .bold()
                    .padding(.top)
                
                
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "figure.walk")
                            .foregroundStyle(.blue)
                        Text("최적 동선을 추천드립니다!")
                            .font(.headline)
                            .foregroundStyle(Color.blue)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("추천 동선")
                                .bold()
                            Spacer()
                            Text("사회과학관 -> 도서관 -> 사이버관")
                        }
                        
                        Text("예상 소요시간: 30분")
                        Text("처리해야 할 쓰레기통 개수: 4개")
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("세부사항").bold()
                            Text("사회과학관 5층 -> 4층 -> 3층")
                            Text("사회과학관 5층 -> 1층")
                            Text("사이버관 3층 -> 2층")
                        }
                    }
                    .font(.subheadline)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(16)
                }
                
                VStack {
                    Text("현재 위치를 지도에서 확인하세요!")
                        .foregroundStyle(.gray)
                        .font(.title2)
                    Image("HUFSMiniMap")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 80)
        }
    }
}

#Preview {
    RouteRecommendationView()
}
