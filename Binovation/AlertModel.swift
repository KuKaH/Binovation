//
//  AlertModel.swift
//  Binovation
//
//  Created by 홍준범 on 4/15/25.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let type: AlertType
    let message: String
    let time: String
    var isHighlighted: Bool = false
}

enum AlertType {
    case critical
    case warning
    
    var iconName: String {
        switch self {
        case .critical: return "exclamationmark.triangle.fill"
        case .warning: return "exclamationmark.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .critical: return .red
        case .warning: return .orange
        }
    }
}
