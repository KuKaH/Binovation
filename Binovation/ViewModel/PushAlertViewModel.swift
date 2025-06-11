//
//  PushAlertViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import Foundation
import Combine
import SwiftUICore
import SwiftUI

protocol PushAlert: Identifiable {
    var id: UUID { get }
    var building: String { get }
    var floor: Int { get }
    var date: Date { get }
}

struct ComplaintAlert: PushAlert, Equatable {
    let id = UUID()
    let building: String
    let floor: Int
    let content: String
    let date: Date
}

struct CapacityAlert: PushAlert, Equatable {
    let id = UUID()
    let building: String
    let floor: Int
    let capacity: Int
    let date: Date
    
    var message: String {
        if capacity >= 100 {
            return "\(building) \(floor)층 일반 쓰레기통이 가득 찼어요!"
        } else {
            return  "\(building) \(floor)층 일반 쓰레기통이 곧 가득 차요!"
        }
    }
    
    var subMessage: String? {
        if capacity >= 100 {
            return "지금 수거하세요!"
        } else {
            return "30분 내에 수거 추천드려요!"
        }
    }
    
    var level: Level {
        capacity >= 100 ? .danger : .warning
    }
    
    enum Level {
        case warning, danger
        
        var iconName: String {
            switch self {
            case .warning: return "exclamationmark.triangle.fill"
            case .danger: return  "exclamationmark.octagon.fill"
            }
        }
        
        var iconColor: SwiftUI.Color {
            switch self {
            case .warning: return .orange
            case .danger: return .red
            }
        }
    }
}


class PushAlertViewModel: ObservableObject {
    static let shared = PushAlertViewModel()
    
    @Published var complaintAlerts: [ComplaintAlert] = []
    
    var complaintAlertsToday: [ComplaintAlert] {
        complaintAlerts.filter { Calendar.current.isDateInToday($0.date)}
    }
    
    var complaintAlertsPast: [ComplaintAlert] {
        complaintAlerts.filter { !Calendar.current.isDateInToday($0.date)}
    }
    
    @Published var capacityAlerts: [CapacityAlert] = []
    
    var todayAlerts: [CapacityAlert] {
        capacityAlerts.filter { Calendar.current.isDateInToday($0.date)}
    }
    
    var previousAlerts: [CapacityAlert] {
        capacityAlerts.filter { !Calendar.current.isDateInToday($0.date)}
    }
    
    private init() {}
    
    func handleComplaintPush(from userInfo: [AnyHashable: Any]) {
        guard
            let building = userInfo["building"] as? String,
            let floor = userInfo["floor"] as? Int,
            let content = userInfo["content"] as? String
        else {
            print("민원 알림 파싱 실패")
            return
        }
        
        let alert = ComplaintAlert(building: building,
                                   floor: floor,
                                   content: content,
                                   date: Date())
        
        DispatchQueue.main.async {
            self.complaintAlerts.insert(alert, at: 0)
        }
    }
    
    func handleCapacityPush(from userInfo: [AnyHashable: Any]) {
        guard
            let building = userInfo["building"] as? String,
            let floor = userInfo["floor"] as? Int,
            let capacity = userInfo["capacity"] as? Int
        else {
            print("용량 알림 파싱 실패")
            return
        }
        
        let alert = CapacityAlert(building: building, floor: floor, capacity: capacity, date: Date())
        
        DispatchQueue.main.async {
            self.capacityAlerts.insert(alert, at: 0)
        }
    }
}
