//
//  Dancer.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import Foundation

struct Dancer: Codable {
    let id: String
    let name: String
    let lastUpdate: Date
    let description: String?
    let profileImageURL: String
//    let tags: [String]
    
    let youtubeURL: String?
    let instagramURL: String?
    let videoThumbnailURL: String
    let schedules: [DanceClass]
}
