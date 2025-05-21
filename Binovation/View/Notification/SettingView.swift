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
    @AppStorage("settingTime") private var settingTime: Bool = true
    
    @AppStorage("startHour") private var startHour: Int = 9
    @AppStorage("startMinute") private var startMinute: Int = 0
    @AppStorage("endHour") private var endHour: Int = 18
    @AppStorage("endMinute") private var endMinute: Int = 0
    
    var body: some View {
        List {
            Toggle("푸시 알림 받기", isOn: $pushEnabled)
            Toggle("알림음", isOn: $soundEnabled)
            Toggle("알림 수신 시간", isOn: $settingTime)
            
            if settingTime {
                Section {
                    HStack {
                        Picker("시작 시간", selection: $startHour) {
                            ForEach(0..<24, id: \.self) { hour in
                                Text(String(format: "%02d:00", hour)).tag(hour)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    HStack {
                        Picker("종료 시간", selection: $endHour) {
                            ForEach(0..<24, id: \.self) { hour in
                                Text(String(format: "%02d:00", hour)).tag(hour)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
            }
        }
        .navigationTitle("알림 설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingView()
}
