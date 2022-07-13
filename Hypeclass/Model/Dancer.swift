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
    let description: String
    let tags: [String]
    
    let links: [String]
    let profileImage: [String]
    let schedules: [DanceClass]
}

