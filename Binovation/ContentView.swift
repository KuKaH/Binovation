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
            NotificationView()
                .tabItem {
                    Label("알림", systemImage: "bell.fill")
                }
            
            StatisticView()
                .tabItem {
                    Label("통계", systemImage: "chart.bar.fill")
                }
            
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
            }
            
            CapacityView()
                .tabItem {
                    Label("용량", systemImage: "star.fill")
                }
            
            
            RouteRecommendationView()
                .tabItem {
                    Label("동선 추천", systemImage: "house.fill")
                }
        }
        .tint(Color.binovationBackground)
    }
}

#Preview {
    ContentView()
}
