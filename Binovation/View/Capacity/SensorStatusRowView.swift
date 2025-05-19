//
//  SensorStatusRowView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import SwiftUI

struct SensorStatusRowView: View {
    let floorName: String
    let capacity: Int
    
    var barColor: Color {
        switch capacity {
        case 0..<50: return .green
        case 50..<80: return .yellow
        default: return .red
        }
    }
    
    var body: some View {
        HStack(spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "#D0E2F5"))
                    .frame(width: 70, height: 70)
                
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.blue)
            }
            
            Text(floorName)
                .frame(width: 100)
                .font(.notoSans(size: 20))
                .padding(.leading, -10)
            
            HStack(spacing: 4) {
                ProgressView(value: Double(capacity), total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: barColor))
                    .frame(width: 100, height: 8)
                    .scaleEffect(x: 1, y: 3, anchor: .center)
                Text("\(capacity)")
                    .frame(width: 30)
                    .font(.headline)
                    .foregroundStyle(barColor)
                    .padding(.leading, 12)
            }
            .frame(width: 150, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .background(Color.white)
    }
}

//#Preview {
//    SensorStatusRowView()
//}
