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
    @ObservedObject private var appTabManager = AppTabManager.shared
    
    @State private var selectedTab = 2

    var body: some View {
        TabView(selection: $appTabManager.selectedAppTab) {
            NotificationView()
                .tabItem {
                    Label("알림", systemImage: "bell.fill")
                }
                .tag(Tab.notification)
            
            StatisticView()
                .tabItem {
                    Label("통계", systemImage: "chart.bar.fill")
                }
                .tag(Tab.statistic)
            
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
                .tag(Tab.home)
            
            CapacityView()
                .tabItem {
                    Label("용량", systemImage: "trash.fill")
                }
                .tag(Tab.capacity)
            
            
            RouteRecommendationView()
                .tabItem {
                    Label("동선 추천", systemImage: "point.bottomleft.forward.to.point.topright.scurvepath")
                }
                .tag(Tab.route)
        }
        .tint(Color.binovationBackground)
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                granted, error in
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
