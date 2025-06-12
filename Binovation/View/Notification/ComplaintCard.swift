//
//  ComplaintCard.swift
//  Binovation
//
//  Created by 홍준범 on 6/13/25.
//

import SwiftUI

struct ComplaintCard: View {
    let complaint: Complaint
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.red)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(complaint.building) \(complaint.floor)층 '\(complaint.content)' 민원 접수!")
                    .font(.body)
                    .foregroundStyle(.black)
                
                HStack {
                    Text("현장 점검이 필요해요!")
                        .font(.body)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text(formattedDate(complaint.createdAt))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 HH:mm"
        return formatter.string(from: date)
    }
}

struct ComplaintDetailPopup: View {
    let complaint: Complaint
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { onDismiss() }
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("\(complaint.building) \(complaint.floor)층")
                        .font(.headline)
                    Spacer()
                    Text(complaint.createdAt.formatted(date: .numeric, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("민원 내용")
                        .font(.caption)
                        .bold()
                    Text(complaint.content)
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
        .animation(.easeInOut, value: complaint)
    }
}

//#Preview {
//    ComplaintCard()
//}
