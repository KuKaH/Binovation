import SwiftUI

struct PushAlertView: View {
    @ObservedObject var viewModel: PushAlertViewModel
    
    var body: some View {
        VStack {
            if viewModel.alerts.isEmpty {
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
                    Section(header: HStack {
                        Text("오늘")
                        Spacer()
                        Button("알림 비우기") {
                            print("푸시 알림 비우기")
                        }
                        .font(.caption)
                        .foregroundStyle(.blue)
                    })
                    {
                        ForEach(viewModel.todayAlerts) { alert in
                            PushAlertCardView(alert: alert)
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
            }
        }
        .onAppear {
            viewModel.fetchPushAlerts()
        }
        .refreshable {
            viewModel.fetchPushAlerts()
        }

    }
}
