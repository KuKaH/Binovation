import SwiftUI

struct PushAlertCardView: View {
    let alert: PushAlert
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: alert.level.icon)
                .foregroundStyle(Color(alert.level.color))
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(alert.building) \(alert.floor) 쓰레기통이 \(Int(alert.currentFill))% 찼어요!")
                    .font(.body)
                    .foregroundStyle(.black)
                
                HStack {
                    Text(alert.message)
                        .font(.body)
                        .foregroundStyle(.black)
                    Spacer()
                    Text(formattedDate(alert.date))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    // ✅ 한글 날짜 포맷 함수
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 🇰🇷 한국어로 설정
        formatter.dateFormat = "M월 d일 HH:mm" // 예: 6월 12일 15:42
        return formatter.string(from: date)
    }
}
