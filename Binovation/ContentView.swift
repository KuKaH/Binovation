//
//  ContentView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import SwiftUI

enum Tab {
    case notification
    case statistic
    case home
    case capacity
    case route
}

struct ContentView: View {
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NotificationView()
                .tabItem {
                    Label("알림", systemImage: "bell.fill")
                }
                .tag(0)
            
            StatisticView()
                .tabItem {
                    Label("통계", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
                .tag(2)
            
            CapacityView()
                .tabItem {
                    Label("용량", systemImage: "trash.fill")
                }
                .tag(3)
            
            
            RouteRecommendationView()
                .tabItem {
                    Label("동선 추천", systemImage: "point.bottomleft.forward.to.point.topright.scurvepath")
                }
                .tag(4)
        }
        .tint(Color.binovationBackground)
    }
}

#Preview {
    ContentView()
}
