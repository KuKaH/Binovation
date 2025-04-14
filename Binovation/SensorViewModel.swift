//
//  TrashViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import Combine

class SensorViewModel: ObservableObject {
    @Published var sensorDataByBuilding: [String: [SensorData]] = [:]
    private var cancellables = Set<AnyCancellable>()
    
    func fetchSensorDate() {
        guard let url = URL(string: "http://3.107.139.2/sensors") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [SensorData].self, decoder: JSONDecoder())
            .map { sensors in
                Dictionary(grouping: sensors) { sensor in
                    if sensor.device_name.contains("Lib") {
                        return "도서관"
                    } else if sensor.device_name.contains("Hum") {
                        return "인문관"
                    } else if sensor.device_name.contains("Sci") {
                        return "사과관"
                    } else if sensor.device_name.contains("Test") {
                        return "테스트"
                    } else {
                        return "기타"
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("에러 발생: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self ] groupedData in
                self?.sensorDataByBuilding = groupedData
            })
            .store(in: &cancellables)
    }
    
    
}
