//
//  Color+Extension.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI

extension Color {
    static let binovationBackground = Color(red: 48/255, green: 51/255, blue: 84/255)
    static let dropdownBackground = Color(red: 221/255, green: 231/255, blue: 243/255)
}

extension Color {
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)

            let r = Double((int >> 16) & 0xFF) / 255.0
            let g = Double((int >> 8) & 0xFF) / 255.0
            let b = Double(int & 0xFF) / 255.0

            self.init(red: r, green: g, blue: b)
        }
}

extension Font {
    static let spaceGrotesk: Font = .custom("SpaceGrotesk-VariableFont_wght", size: 12)
    static let madimiOne: Font = .custom("MadimiOne-Regular", size: 30)
    static let notoSans: Font = .custom("NotoSansKR-VariableFont_wght", size: 16)
}
