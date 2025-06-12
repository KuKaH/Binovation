//
//  NotificationView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

enum NotificationTab: String, CaseIterable {
//    case all = "전체"
    case complaint = "민원"
    case push = "푸시"
}

struct NotificationView: View {
    @ObservedObject private var tabManager = NotificationTabManager.shared
    @StateObject private var complaintVM = ComplaintViewModel()
    @StateObject private var pushVM = PushAlertViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("알림")
                        .font(.headline)
                        .foregroundStyle(.black)
                    Spacer()
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gearshape")
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                HStack(spacing: 0) {
                    ForEach(NotificationTab.allCases, id: \.self) { tab in
                        Button(action: {
                            tabManager.selectedTab = tab
                        }) {
                            VStack(spacing: 4) {
                                Text(tab.rawValue)
                                    .foregroundStyle(tabManager.selectedTab == tab ? .black : .gray)
                                    .fontWeight(tabManager.selectedTab == tab ? .bold : .regular)
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundStyle(tabManager.selectedTab == tab ? .black : .clear)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.top, 5)
                .background(Color.white)
                
                Divider()
                
                if tabManager.selectedTab == .push {
                    PushAlertView(viewModel: PushAlertViewModel.shared)
                } else if tabManager.selectedTab == .complaint {
                    ComplaintView(viewModel: ComplaintViewModel.shared)
                } else {
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Image(systemName: "bell")
                            .font(.system(size: 40))
                            .foregroundStyle(.gray.opacity(0.3))
                        Text("새로운 알림이 없어요")
                            .foregroundStyle(.gray.opacity(0.5))
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    NotificationView()
}
