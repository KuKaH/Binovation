//
//  PushAlertCardView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct PushAlertCardView: View {
    let alert: PushAlert
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: alert.level.iconName)
                .foregroundStyle(alert.level.iconColor)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(alert.message)
                    .font(.body)
                    .foregroundStyle(.black)
                Text(alert.dateString)
                    .font(.caption)
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
