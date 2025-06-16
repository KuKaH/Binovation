import SwiftUI

struct ComplaintView: View {
    @ObservedObject var viewModel: ComplaintViewModel
    @State private var selectedComplaint: Complaint? = nil
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack {
            if viewModel.complaints.isEmpty {
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
                    if !viewModel.today.isEmpty {
                        Section(header: HStack {
                            Text("오늘")
                            Spacer()
                            Button("알림 비우기") {
                                showDeleteAlert = true
                            }
                            .alert("정말 알림을 비우시겠습니까?", isPresented: $showDeleteAlert) {
                                Button("비우기", role: .destructive) {
                                    viewModel.clearAllComplaints()
                                }
                                Button("취소", role: .cancel) { }
                            } message: {
                                Text("이 작업은 되돌릴 수 없습니다.")
                            }
                            .font(.caption)
                            .foregroundStyle(.blue)
                        })
                        {
                            ForEach(viewModel.today) { complaint in
                                Button(action: {
                                    selectedComplaint = complaint
                                }) {
                                    ComplaintCard(complaint: complaint)
                                }
                            }
                            .onDelete { indexSet in
                                viewModel.delete(filter: { Calendar.current.isDateInToday($0.createdAt) }, at: indexSet)
                            }
                        }
                    }
                    
                    if !viewModel.previous.isEmpty {
                        Section(header: Text("이전 알림")) {
                            ForEach(viewModel.previous) { complaint in
                                Button(action: {
                                    selectedComplaint = complaint
                                }) {
                                    ComplaintCard(complaint: complaint)
                                }
                            }
                            .onDelete { indexSet in
                                viewModel.delete(filter: { !Calendar.current.isDateInToday($0.createdAt) }, at: indexSet)
                                
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.fetchComplaints()
        }
        .refreshable {
            viewModel.fetchComplaints()
        }
        .overlay {
            if let alert = selectedComplaint {
                ComplaintDetailPopup(complaint: alert) {
                    selectedComplaint = nil
                }
            }
        }
    }
}




