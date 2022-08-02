//
//  Event.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/02.
//

import Foundation

class Event: Codable {
    let id: String
    let type: EventType?
    let relatedID: String
    let title: String?
    let coverImageURL: String?
    let description: String?
    let deadLine: Date?
    
    enum EventType: Codable {
        case dancer
        case studio
        case danceClass
    }
}
