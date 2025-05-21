//
//  ComplaintView.swift
//  Binovation
//
//  Created by 홍준범 on 5/21/25.
//

import SwiftUI

struct ComplaintAlert: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let message: String
    let location: String
    let date: Date
    let category: String
}

class ComplaintAlertViewModel: ObservableObject {
    @Published var todayAlerts: [ComplaintAlert] = []
    @Published var previousAlerts: [ComplaintAlert] = []

    func fetchAlerts() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"

        let mock: [ComplaintAlert] = [
            ComplaintAlert(
                title: "기타 민원",
                message: "쓰레기통 주변에 쓰레기들이 쌓여있어서 치워야 할 것 같아요.",
                location: "인문관 4층 일반 쓰레기통",
                date: now.addingTimeInterval(-3600),
                category: "기타"
            ),
            ComplaintAlert(
                title: "악취 민원",
                message: "냄새가 심해요. 빠른 처리 부탁드립니다.",
                location: "사회과학관 2층",
                date: now.addingTimeInterval(-90000),
                category: "악취"
            )
        ]

        todayAlerts = mock.filter { Calendar.current.isDateInToday($0.date) }
        previousAlerts = mock.filter { !Calendar.current.isDateInToday($0.date) }
    }
}

struct ComplaintView: View {
    @StateObject private var viewModel = ComplaintAlertViewModel()
    @State private var selectedAlert: ComplaintAlert? = nil
    
    var body: some View {
        VStack {
            if viewModel.todayAlerts.isEmpty && viewModel.previousAlerts.isEmpty {
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmakr.bubble")
                        .font(.system(size: 40))
                        .foregroundStyle(.gray.opacity(0.3))
                    Text("새로운 민원이 없어요")
                        .foregroundStyle(.gray.opacity(0.5))
                        .font(.subheadline)
                }
                Spacer()
            } else {
                List {
                    if !viewModel.todayAlerts.isEmpty {
                        Section(header: Text("오늘")) {
                            ForEach(viewModel.todayAlerts) { alert in
                                Button(action: {
                                    selectedAlert = alert
                                }) {
                                    ComplaintAlertCardView(alert: alert)
                                }
                            }
                        }
                    }
                    if !viewModel.previousAlerts.isEmpty {
                        Section(header: Text("이전 알림")) {
                            ForEach(viewModel.previousAlerts) { alert in
                                Button(action: {
                                    selectedAlert = alert
                                }) {
                                    ComplaintAlertCardView(alert: alert)
                                }
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
        .overlay {
            if let alert = selectedAlert {
                ComplaintAlertPopup(alert: alert) {
                    selectedAlert = nil
                }
            }
        }
    }
}

struct ComplaintAlertCardView: View {
    let alert: ComplaintAlert
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.red)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(alert.location) \(alert.category) 민원 접수!")
                    .font(.body)
                    .foregroundStyle(.black)
                Text("현장 점검이 필요해요!")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Text(alert.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct ComplaintAlertPopup: View {
    let alert: ComplaintAlert
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(alert.title)
                        .font(.headline)
                    Spacer()
                    Text(alert.date.formatted(date: .numeric, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }

                Text(alert.location)
                    .font(.subheadline)
                    .foregroundStyle(.gray)

                Divider()

                VStack(alignment: .leading, spacing: 4) {
                    Text("내용")
                        .font(.caption)
                        .bold()
                    Text(alert.message)
                }

                Button("닫기") {
                    onDismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .frame(maxWidth: 360)
            .shadow(radius: 10)
        }
        .animation(.easeInOut, value: alert)
    }
}

#Preview {
    ComplaintView()
}
