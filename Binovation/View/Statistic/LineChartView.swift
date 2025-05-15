//
//  LineChartView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct LineChartView: View {
    var body: some View {
        HStack {
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 80))
                    path.addLine(to: CGPoint(x: 40, y: 50))
                    path.addLine(to: CGPoint(x: 80, y: 60))
                    path.addLine(to: CGPoint(x: 120, y: 30))
                    path.addLine(to: CGPoint(x: 160, y: 70))
                }
                .stroke(Color.blue, lineWidth: 2)
            }
            .frame(width: 180, height: 100)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    LineChartView()
}
