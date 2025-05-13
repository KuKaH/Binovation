//
//  ChartView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct BarChartView: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ForEach(0..<7) { i in
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(i == 1 ? Color.red : Color.gray)
                        .frame(width: 20, height: CGFloat(20 + i * 30))
                    
                Text("1.1")
                        .font(.caption2)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}



#Preview {
    BarChartView()
}
