//
//  ContentView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
            }
            
            StatisticView()
                .tabItem {
                    Label("통계", systemImage: "chart.bar.fill")
                }
            
            NotificationView()
                .tabItem {
                    Label("알림", systemImage: "bell.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
