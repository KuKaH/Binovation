//
//  ChartView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI
import Charts
import Foundation

struct ChartPoint: Identifiable {
    let id = UUID()
    let label: String  // 예: "월", "화" 등
    let value: Double  // 쓰레기 적재량 평균
}

struct BarChartView: View {
    let data: [ChartPoint]
    
    private var highestValue: Double {
        data.map(\.value).max() ?? 0
    }
    
    var body: some View {
        Chart(data) { point in
            BarMark(
                x: .value("요일", point.label),
                y: .value("적재량", point.value)
            )
            .foregroundStyle(point.value == highestValue ? Color.red : Color.gray)
            .annotation(position: .top) {
                Text(String(format: "%.1f", point.value))
                    .font(.caption2)
                    .foregroundColor(.primary)
            }
        }
        .chartYScale(domain: [0, 100])
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 220)
        .padding(.horizontal)
    }
}

//import SwiftUI
//
//struct BarChartView: View {
//    let weekdayLables: [String]
//    let weekdayValues: [Double]
//    
//    // 최대값이 0이면 1로 처리해서 NaN 방지
//    var maxValue: Double {
//        let max = weekdayValues.max() ?? 0
//        return max > 0 ? max : 1
//    }
//    
//    var highestValue: Double {
//        weekdayValues.max() ?? 0
//    }
//    
//    
//    var body: some View {
//        HStack(alignment: .bottom, spacing: 18) {
//            ForEach(0..<weekdayValues.count, id: \.self) { i in
//                let value = weekdayValues[i]
//                let color: Color = value == highestValue ? .red : .gray
//                
//                VStack(spacing: 4) {
//                    RoundedRectangle(cornerRadius: 0)
//                        .fill(color)
//                        .frame(width: 25, height: CGFloat(weekdayValues[i] / maxValue * 200))
//                        .shadow(radius: 2)
//                    
//                    Text(String(format: "%.1f", weekdayValues[i]))
//                        .font(.caption2)
//                    
//                    Text(weekdayLables[i])
//                        .font(.caption2)
//                        .foregroundStyle(.gray)
//                }
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .padding(.horizontal, 16)
//    }
//}

//#Preview {
//    BarChartView()
//}
