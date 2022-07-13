//
//  Dancer.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import Foundation

struct Dancer: Identifiable {
    let id: String
    let name: String
    let lastUpdate: Date
    let description: String?
    let tags: [String]
    
    let platformUrls: [Platform: String]
    let profileImageUrl: [String]
    let videoThumbnailUrl: [String]
    let schedules: [DanceClass]
}

enum Platform {
    case youtube
    case instagram
}
