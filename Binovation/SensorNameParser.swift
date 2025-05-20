//
//  SensorNameParser.swift
//  Binovation
//
//  Created by 홍준범 on 5/20/25.
//

import Foundation

struct SensorNameParser {
    static func parse(_ deviceName: String) -> (building: String, floor: String) {
           if deviceName.contains("Lib") {
               return ("도서관", extractFloor(from: deviceName))
           } else if deviceName.contains("Hum") {
               return ("인문관", extractFloor(from: deviceName))
           } else if deviceName.contains("Sci") {
               return ("사과관", extractFloor(from: deviceName))
           } else if deviceName.contains("Cyber") {
               return ("사이버관", extractFloor(from: deviceName))
           } else if deviceName.contains("EDU") {
               return ("교개원", extractFloor(from: deviceName))
           } else {
               return ("기타", "?")
           }
       }
    
    private static func extractFloor(from name: String) -> String {
        let parts = name.components(separatedBy: "_")
        return parts.last?.replacingOccurrences(of: "floor", with: "") ?? "?"
    }
    
    static func fullLabel(from deviceName: String) -> String {
        let (building, floor) = parse(deviceName)
        return "\(building) \(floor)층"
    }
}
