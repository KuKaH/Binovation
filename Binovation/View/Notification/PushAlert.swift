//
//  PushAlert.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import Foundation
import SwiftUICore

enum AlertLevel {
    case warning
    case critical
    
    var iconColor: Color {
        switch self {
        case .warning: return .orange
        case .critical: return .red
        }
    }
    
    var iconName: String {
        return "exclamationmark.triangle.fill"
    }
    
    var messageSuffix: String {
        switch self {
        case .warning: return "곧 가득 차요! 30분 내에 수거하세요!"
        case .critical: return "가득 찼어요! 지금 수거하세요"
        }
    }
}

struct PushAlert: Identifiable {
    let id = UUID()
    let building: String
    let floor: String
    let message: String
    let date: Date
    let dateString: String
    let level: AlertLevel
}
