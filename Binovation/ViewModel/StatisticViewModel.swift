//
//  StatisticViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 5/19/25.
//

import Foundation
import Combine

struct WeeklyAverageTrash: Identifiable {
    let id = UUID()
    let floorName: String
    let buildingName: String
    let floorNumber: String
    let dailyAverages: [String: Double]
}

class StatisticViewModel: ObservableObject {
    @Published var weeklyAverages: [WeeklyAverageTrash] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeeklyAverages() {
        guard let url = URL(string: "http://3.107.139.2/trash/weekly-average/") else {
            self.errorMessage = "유효하지 않은 URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> [String: [String: Double]] in
                let decoder = JSONDecoder()
                return try decoder.decode([String: [String: Double]].self, from: result.data)
            }
            .map { rawData -> [WeeklyAverageTrash] in
                rawData.map { key, value in
                    let components = key.split(separator: "_")
                    let buliding = String(components[0])
                    let floor = String(components[1])
                    return WeeklyAverageTrash(floorName: key, buildingName: buliding, floorNumber: floor, dailyAverages: value)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] weeklyData in
                self?.weeklyAverages = weeklyData
            }
            .store(in: &cancellables)
    }
    
    func averageByDay(for building: String) -> ([String], [Double]) {
        let filtered = weeklyAverages.filter { $0.buildingName == building}
        
        //날짜별로 값 모으기
        var weekdayDict: [String: [Double]] = [:]
        let isoFormatter = ISO8601DateFormatter()
        let weekdaySymbols = DateFormatter().shortWeekdaySymbols ?? ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        
        for item in filtered {
            for (dateStr, value) in item.dailyAverages {
                if let date = isoFormatter.date(from: dateStr + "T00:00:00Z") {
                    let weekdayIndex = Calendar.current.component(.weekday, from: date) - 1
                    let weekdayName = weekdaySymbols[weekdayIndex]
                    weekdayDict[weekdayName, default: []].append(value)
                }
            }
        }
        
        let labels = weekdaySymbols
        let values = labels.map { day -> Double in
            let values = weekdayDict[day] ?? []
            return values.isEmpty ? 0.0 : values.reduce(0, +) / Double(values.count)
        }
        
        return (labels, values)
    }
    
    func chartData(for building: String) -> [ChartPoint] {
        let (labels, values) = averageByDay(for: building)
        return zip(labels, values).map { ChartPoint(label: $0.0, value: $0.1)}
    }
}
