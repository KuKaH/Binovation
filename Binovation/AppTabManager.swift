//
//  AppTabManager.swift
//  Binovation
//
//  Created by 홍준범 on 6/13/25.
//

import Foundation
import SwiftUI

class AppTabManager: ObservableObject {
    static let shared = AppTabManager()
    @Published var selectedAppTab: Tab = .home
}
