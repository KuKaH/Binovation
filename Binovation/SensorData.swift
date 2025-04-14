//
//  SensorData.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation

struct SensorData: Codable, Identifiable {
    var id: String { device_name }
    let device_name: String
    let distance: Double
    let date_time: String
    let fill_percent: Int
    let level: Int
    let status: String
}
