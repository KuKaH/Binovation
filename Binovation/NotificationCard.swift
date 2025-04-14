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
        HStack(spacing: 12) {
            Image(systemName: alert.type.iconName)
                .foregroundStyle(alert.type.color)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(alert.message)
                    .font(.body)
                Text(alert.time)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color.white)
    }
}

//#Preview {
//    NotificationCard()
//}
