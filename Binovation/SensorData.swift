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
    let status: String
}

private func parseDeviceName(_ name: String) -> (String, String) {
    if name.contains("Lib") {
        let parts = name.components(separatedBy: "_")
        let floor = parts.last?.replacingOccurrences(of: "floor", with: "") ?? "?"
        return ("도서관", floor)
    }
    
    return ("기타", "?")
}

