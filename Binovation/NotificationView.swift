//
//  NotificationView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

enum NotificationTab: String, CaseIterable {
    case all = "전체"
    case complaint = "민원"
    case push = "푸시"
}

struct NotificationView: View {
    @State private var selectedTab: NotificationTab = .complaint
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("알림")
                    .font(.headline)
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    //설정 화면 이동
                }) {
                    Image(systemName: "gearshape")
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            HStack {
                ForEach(NotificationTab.allCases, id: \.self) { tab in
                    Button(action: {
                        selectedTab = tab
                    }) {
                        VStack(spacing: 4) {
                            Text(tab.rawValue)
                                .foregroundStyle(selectedTab == tab ? .black : .gray)
                                .fontWeight(selectedTab == tab ? .bold : .regular)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.selectedTab == tab ? .black : .clear)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.top, 5)
            .background(Color.white)
            
            Divider()
            
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

#Preview {
    NotificationView()
}
