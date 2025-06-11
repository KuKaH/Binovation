//
//  PushAlertCardView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct PushAlertCardView: View {
    let alert: CapacityAlert
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: alert.level.iconName)
                .foregroundStyle(alert.level.iconColor)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(alert.message)
                    .font(.body)
                    .foregroundStyle(.black)
                if let sub = alert.subMessage {
                    Text(sub)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Text(alert.date.formatted(.dateTime.month().day().hour().minute()))
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

//#Preview {
//    PushAlertCardView()
//}
