//
//  NotificationView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import SwiftUI

struct NotificationView: View {
    let todayAlerts: [AlertItem] = [
        AlertItem(type: .critical, message: "도서관 5층 일반 쓰레기통이 가득 찼어요!", time: "4월 12일 16:54"),
        AlertItem(type: .warning, message: "도서관 4층 일반 쓰레기통이 가득 찼어요!", time: "4월 12일 16:50"),
        AlertItem(type: .critical, message: "도서관 2층 재활용 쓰레기통이 가득 찼어요!", time: "4월 12일 14:38"),
    ]
    
    let previousAlerts: [AlertItem] = [
        AlertItem(type: .warning, message: "도서관 4층 재활용 쓰레기통이 곧 가득 차요!", time: "4월 11일 17:13")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("알림")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {}) {
                    Image(systemName: "gearshape.fill")
                }
            }
            .padding()
            
            List {
                Section(header: Text("오늘")) {
                    ForEach(todayAlerts) { alert in
                        NotificationCard(alert: alert)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.visible)
                            .swipeActions {
                                Button(role: .destructive) {
                                    print("삭제")
                                } label: {
                                    Label("삭제", systemImage: "trash")
                                }
                            }
                    }
                }
                
                Section(header: Text("이전 알림")) {
                    ForEach(previousAlerts) { alert in
                        NotificationCard(alert: alert)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.visible)
                            .swipeActions {
                                Button(role: .destructive) {
                                    print("삭제")
                                } label: {
                                    Label("삭제", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .listStyle(.plain) // 테두리 없애기
            //            ScrollView {
            //                VStack(alignment:. leading, spacing: 16) {
            //                    Text("오늘")
            //                        .font(.headline)
            //                        .padding(.horizontal)
            //
            //                    ForEach(todayAlerts) { alert in
            //                        NotificationCard(alert: alert)
            //                            .swipeActions {
            //                                Button(role: .destructive) {
            //                                    print("삭제")
            //                                } label: {
            //                                    Label("삭제", systemImage: "trash")
            //                                }
            //                            }
            //                    }
            //
            //                    Text("이전 알림")
            //                        .font(.headline)
            //                        .padding(.horizontal)
            //                        .padding(.top)
            //
            //                    ForEach(previousAlerts) { alert in
            //                        NotificationCard(alert: alert)
            //                    }
            //                }
            //                .padding(.bottom)
            //            }
        }
    }
}

#Preview {
    NotificationView()
}
