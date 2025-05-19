//
//  ChartView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct BarChartView: View {
    let weekdayLables: [String]
    let weekdayValues: [Double]
    
    // 최대값이 0이면 1로 처리해서 NaN 방지
       var maxValue: Double {
           let max = weekdayValues.max() ?? 0
           return max > 0 ? max : 1
       }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 18) {
            ForEach(0..<weekdayValues.count, id: \.self) { i in
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.gray)
                        .frame(width: 25, height: CGFloat(weekdayValues[i] / maxValue * 200))
                        .shadow(radius: 4)
                    
                    Text(String(format: "%.1f", weekdayValues[i]))
                        .font(.caption2)
                    
                    Text(weekdayLables[i])
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    BarChartView()
//}
