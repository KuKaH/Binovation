//
//  SensorData.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation

struct SensorData: Identifiable {
    let id = UUID()
    let height: Double
    let timestamp: Date
}
