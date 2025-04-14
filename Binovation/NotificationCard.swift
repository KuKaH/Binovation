//
//  NotificationCard.swift
//  Binovation
//
//  Created by 홍준범 on 4/15/25.
//

import SwiftUI

struct NotificationCard: View {
    let alert: AlertItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: alert.type.iconName)
                .foregroundStyle(alert.type.color)
                .font(.title2)
                .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(alert.message)
                    .font(.body)
                Text(alert.time)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(alert.isHighlighted ? Color.blue : Color.clear, lineWidth: 2)
        )
        .padding(.horizontal)
    }
}

//#Preview {
//    NotificationCard()
//}
