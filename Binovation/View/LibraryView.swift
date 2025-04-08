//
//  LibraryView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI

struct LibraryView: View {
    let libraryFloors = [
        ("도서관 5층", 100),
        ("도서관 4층", 45),
        ("도서관 3층", 70),
        ("도서관 2층", 90),
        ("도서관 1층", 90),
    ]
    
    var body: some View {
        BuildingDetailView(buildingName: "도서관", floorData: libraryFloors)
    }
}
