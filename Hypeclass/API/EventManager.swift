//
//  EventManager.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/02.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventManager {
    
    static let shared = EventManager()
    
    private init() {} // 객체 생성을 막기 위한 접근 제한
    
    func requestAllEvents() async throws -> [Event]? {
        let snapshot = try await Constant.eventRef.getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: Event.self)
        }
    }
}
