//
//  Studio.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/13.
//

import Foundation

struct Studio: Identifiable {
    let id: String
    let name: String
    let description: String
    let classes: [DanceClass]
}
