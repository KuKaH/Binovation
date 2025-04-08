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
        HStack {
            Image(systemName: "trash.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.blue)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(floorName)
                    .font(.headline)
                Text("Capacity: \(capacity)%")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                ProgressView(value: Double(capacity), total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: barColor))
                    .frame(width: 100)
                Text("\(capacity)")
                    .font(.headline)
                    .foregroundStyle(barColor)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}

//#Preview {
//    SensorStatusRowView()
//}
