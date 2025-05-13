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
        guard let url = URL(string: "https://your-server.com/api/sensordata") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [SensorData].self, decoder: JSONDecoder())
            .map { sensorDataList in
                sensorDataList.compactMap( {$0.toPushAlert()} )
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion {
                    print("알림 불러오기 실패: \(error)")
                }
            }, receiveValue: { [weak self] alerts in
                let now = Date()
                self?.todayAlerts = alerts.filter { Calendar.current.isDateInToday($0.date) }
                self?.previousAlerts = alerts.filter { !Calendar.current.isDateInToday($0.date)}
            })
            .store(in: &cancellables)
    }
}
