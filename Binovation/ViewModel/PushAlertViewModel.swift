//
//  PushAlertViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import Foundation
import Combine

class PushAlertViewModel: ObservableObject {
    @Published var todayAlerts: [PushAlert] = []
    @Published var previousAlerts: [PushAlert] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAlerts() {
        //서버 연동코드 주석처리
//        guard let url = URL(string: "https://your-server.com/api/sensordata") else { return }
//        
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: [SensorData].self, decoder: JSONDecoder())
//            .map { sensorDataList in
//                sensorDataList.compactMap( {$0.toPushAlert()} )
//            }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: {completion in
//                if case .failure(let error) = completion {
//                    print("알림 불러오기 실패: \(error)")
//                }
//            }, receiveValue: { [weak self] alerts in
//                let now = Date()
//                self?.todayAlerts = alerts.filter { Calendar.current.isDateInToday($0.date) }
//                self?.previousAlerts = alerts.filter { !Calendar.current.isDateInToday($0.date)}
//            })
//            .store(in: &cancellables)
        
        let now = Date()
               let formatter = DateFormatter()
               formatter.locale = Locale(identifier: "ko_KR")
               formatter.dateFormat = "M월 d일 HH:mm"

               let mockAlerts: [PushAlert] = [
                   PushAlert(
                       building: "도서관", floor: "3",
                       message: "도서관 3층 쓰레기통이 90% 찼습니다. 30분 내 수거 권장",
                       date: now,
                       dateString: formatter.string(from: now),
                       level: .warning
                   ),
                   PushAlert(
                       building: "인문관", floor: "2",
                       message: "인문관 2층 쓰레기통이 가득 찼습니다. 지금 수거하세요!",
                       date: now.addingTimeInterval(-3600),
                       dateString: formatter.string(from: now.addingTimeInterval(-3600)),
                       level: .critical
                   ),
                   PushAlert(
                       building: "사과관", floor: "5",
                       message: "사과관 5층 쓰레기통이 80% 찼습니다. 30분 내 수거 권장",
                       date: now.addingTimeInterval(-86400),
                       dateString: formatter.string(from: now.addingTimeInterval(-86400)),
                       level: .warning
                   )
               ]

               self.todayAlerts = mockAlerts.filter { Calendar.current.isDateInToday($0.date) }
               self.previousAlerts = mockAlerts.filter { !Calendar.current.isDateInToday($0.date) }
    }
}
