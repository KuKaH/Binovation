//
//  LineChartView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI
import Charts

import SwiftUI
import Charts

struct LineChartView: View {
    // 임시 데이터: 0~23시, 40~100% 랜덤 적재량
    let data: [HourlyTrashData] = (0..<24).map { hour in
        HourlyTrashData(hour: hour, value: Double.random(in: 40...100))
    }

    var body: some View {
        ScrollView(.horizontal) {
            Chart(data) { point in
                LineMark(
                    x: .value("시간", "\(point.hour)시"),
                    y: .value("적재량", point.value)
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 2))

                PointMark(
                    x: .value("시간", "\(point.hour)시"),
                    y: .value("적재량", point.value)
                )
                .symbolSize(25)
            }
            .chartYScale(domain: 0...100)
            .frame(width: 700, height: 180) // ✅ 24시간 충분히 표현되도록 넓게 설정
        }
        .frame(height: 200) // 외부 ScrollView 높이 제한
    }
}

struct HourlyTrashData: Identifiable {
    let id = UUID()
    let hour: Int      // 0 ~ 23
    let value: Double  // 적재량 (%)
}

#Preview {
    LineChartView()
}
