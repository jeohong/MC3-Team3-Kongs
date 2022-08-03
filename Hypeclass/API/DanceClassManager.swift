//
//  DanceClassManager.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/26.
//

import Foundation

class DanceClassManager {
    static let shared = DanceClassManager()
    
    static var myClasses: [DanceClass]?
    
    func createDanceClass(model: DanceClass) {
        do {
            try Constant.danceClassRef.document("\(model.id)").setData(from: model)
        } catch let error {
            print("Error writing dance class to Firestore: \(error)")
        }
    }
    
    func requestDanceClassBy(dancerID id: String) async throws -> [DanceClass]? {
        let snapshot = try await Constant.danceClassRef.whereField("dancerID", isEqualTo: id).getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: DanceClass.self)
        }
    }
    
    func requestDanceClassesBy(dancerIDs ids: [String]) async throws -> [DanceClass]? {
        let snapshot = try await Constant.danceClassRef.whereField("dancerID", in: ids).getDocuments()

        return snapshot.documents.compactMap { document in
            try? document.data(as: DanceClass.self)
        }
    }
    
    func requestDanceClassBy(studioID id: String) async throws -> [DanceClass]? {
        let snapshot = try await Constant.danceClassRef.whereField("studioID", isEqualTo: id).getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: DanceClass.self)
        }
    }
}
