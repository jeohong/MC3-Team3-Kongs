//
//  Studio.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/13.
//

import Foundation

struct Studio: Codable {
    let id: String
    let name: String
    let description: String?
//    let tags: [String]
    let classes: [DanceClass]
    let platformURLs: [String] //URL 내에 플랫폼 정보가 담겨져있어 URL 자체만 담도록 변경
}
