//
//  SensorData.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation

struct SensorData: Codable, Identifiable, Equatable {
    var id: String { device_name }
    let device_name: String
    let distance: Double
    let date_time: String
    let fill_percent: Int
    let level: Int
    let status: String
}

extension SensorData {
    func toPushAlert() -> PushAlert? {
        guard fill_percent == 80 || fill_percent == 100 else { return nil }
        
        let level: AlertLevel = (fill_percent == 80) ? .warning : .critical
        
        let isoFormatter = ISO8601DateFormatter()
        guard let parsedDate = isoFormatter.date(from: date_time) else { return nil }
        
        let displayFormatter = DateFormatter()
        displayFormatter.locale = Locale(identifier: "ko_KR")
        displayFormatter.dateFormat = "M월 d일 HH:mm"
        let dateStr = displayFormatter.string(from: parsedDate)
        
        let (building, floor) = parseDeviceName(device_name)
        
        return PushAlert(building: building,
                         floor: floor,
                         message: "\(building) \(floor)층 쓰레기통이 \(level.messageSuffix)",
                         date: parsedDate,
                         dateString: dateStr,
                         level: level)
    }
    
    private func parseDeviceName(_ name: String) -> (String, String) {
        if name.contains("Lib") {
            let parts = name.components(separatedBy: "_")
            let floor = parts.last?.replacingOccurrences(of: "floor", with: "") ?? "?"
            return ("도서관", floor)
        }
        
        return ("기타", "?")
    }
}

