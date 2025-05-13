//
//  EmergencyBinCardView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI


struct EmergencyBinCardView: View {
    let floor: String
    let percent: Int
    let message: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(floor)
                    .font(.headline)
                    .foregroundStyle(.black)
                Text("\(percent)%")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.red)
                .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

//#Preview {
//    EmergencyBinCardView()
//}
