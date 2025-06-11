//
//  ComplaintView.swift
//  Binovation
//
//  Created by 홍준범 on 5/21/25.
//

import SwiftUI

struct ComplaintView: View {
    @ObservedObject private var viewModel = PushAlertViewModel.shared
    @State private var selectedAlert: ComplaintAlert? = nil
    
    var body: some View {
        VStack {
            if viewModel.complaintAlerts.isEmpty {
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.bubble")
                        .font(.system(size: 40))
                        .foregroundStyle(.gray.opacity(0.3))
                    Text("새로운 민원이 없어요")
                        .foregroundStyle(.gray.opacity(0.5))
                        .font(.subheadline)
                }
                Spacer()
            } else {
                List {
                    Section(header: Text("오늘")) {
                        ForEach(viewModel.complaintAlertsToday) { alert in
                            Button(action: {
                                selectedAlert = alert
                            }) {
                                ComplaintAlertCardView(alert: alert)
                            }
                        }
                     }
                    
                    Section(header: Text("이전 알림")) {
                        ForEach(viewModel.complaintAlertsPast) { alert in
                            Button(action: {
                                selectedAlert = alert
                            }) {
                                ComplaintAlertCardView(alert: alert)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                }
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
                Text("\(alert.building) \(alert.floor)층 \(alert.content) 민원 접수!")
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
                    Text("\(alert.building) \(alert.floor)층")
                        .font(.headline)
                    Spacer()
                    Text(alert.date.formatted(date: .numeric, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }

                Divider()

                VStack(alignment: .leading, spacing: 4) {
                    Text("민원 내용")
                        .font(.caption)
                        .bold()
                    Text(alert.content)
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
        .transition(.opacity.combined(with: .scale))
        .animation(.easeInOut, value: alert)
    }
}

#Preview {
    let vm = PushAlertViewModel.shared
    vm.complaintAlerts = ComplaintAlert.previewData
    return ComplaintView()
}


extension ComplaintAlert {
    static var previewData: [ComplaintAlert] {
        let now = Date()
        return [
            ComplaintAlert(building: "인문관", floor: 4, content: "쓰레기 넘침", date: now),
            ComplaintAlert(building: "사회과학관", floor: 2, content: "악취", date: Calendar.current.date(byAdding: .day, value: -1, to: now)!),
            ComplaintAlert(building: "사과관", floor: 5, content: "벌레 발생", date: Calendar.current.date(byAdding: .day, value: -1, to: now)!)
        ]
    }
}
