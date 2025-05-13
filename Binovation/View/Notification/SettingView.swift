//
//  SettingView.swift
//  Binovation
//
//  Created by 홍준범 on 4/15/25.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("pushEnabled") private var pushEnabled: Bool = true
    @AppStorage("soundEnabled") private var soundEnabled: Bool = true
    
    var body: some View {
        List {
            Toggle("푸시 알림 받기", isOn: $pushEnabled)
            Toggle("알림음", isOn: $soundEnabled)
        }
        .navigationTitle("알림 설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingView()
}
