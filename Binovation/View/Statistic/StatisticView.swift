//
//  StatisticView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI

struct StatisticView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("통계")
                    .font(.title2)
                    .bold()
                
                HStack {
                    Text("도서관 ▼")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    StatisticSummaryCardView(title: "일 평균 비움 횟수", value: "4번")
                    
                    StatisticSummaryCardView(title: "최다 수거 요청 시간", value: "오후 5시")
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("지난주 요약")
                            .bold()
                        Spacer()
                        Text("요약 전체보기")
                            .font(.caption)
                    }
                    
                    BarChartView()
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("일일 통계")
                            .bold()
                        Spacer()
                        Text("요약 전체보기")
                            .font(.caption)
                    }
                    
                    LineChartView()
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("화요일 3-5시 사이는 쓰레기 배출량이 많은 시간대 입니다")
                        .bold()
                    Text("화요일 오후에 1회 추가 순회 추천드립니다.")
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .padding(.top)
        }
    }
}
