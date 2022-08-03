//
//  Event.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/02.
//

import Foundation

struct Event: Codable {
    let id: String
    let type: EventType?
    let relatedID: String
    let title: String?
    let coverImageURL: String?
    let description: String?
    let deadLine: Date?
    
    enum EventType: String, Codable {
        case dancer
        case studio
        case danceClass
    }
}
