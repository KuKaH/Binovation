//
//  PushAlertView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct PushAlertView: View {
    @StateObject private var viewModel = PushAlertViewModel()
    
    var body: some View {
        VStack {
            if viewModel.todayAlerts.isEmpty && viewModel.previousAlerts.isEmpty {
                Spacer()
                VStack {
                    Image(systemName: "bell")
                        .font(.system(size: 40))
                        .foregroundStyle(.gray.opacity(0.3))
                    Text("새로운 알림이 없어요")
                        .foregroundStyle(.gray.opacity(0.5))
                        .font(.subheadline)
                }
                Spacer()
            } else {
                List {
                    if !viewModel.todayAlerts.isEmpty {
                        Section(header: Text("오늘")) {
                            ForEach(viewModel.todayAlerts) { alert in
                                PushAlertCardView(alert: alert)
                            }
                        }
                    }
                    
                    if !viewModel.previousAlerts.isEmpty {
                        Section(header: Text("이전 알림")) {
                            ForEach(viewModel.previousAlerts) { alert in
                                PushAlertCardView(alert: alert)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    viewModel.fetchAlerts()
                }
            }
        }
        .onAppear {
            viewModel.fetchAlerts()
        }
    }
}

#Preview {
    PushAlertView()
}
