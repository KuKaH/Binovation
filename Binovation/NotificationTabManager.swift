//
//  NotificationTabManager.swift
//  Binovation
//
//  Created by 홍준범 on 6/13/25.
//

import Foundation
import SwiftUI

class NotificationTabManager: ObservableObject {
    static let shared = NotificationTabManager()
    @Published var selectedTab: NotificationTab = .complaint
}
