//
//  DancerManager.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/26.
//

import Foundation

class DancerManager {
    static let shared = DancerManager()
    
    func createDancer(id: String, name: String, studios: [String]) {
        let dancer = Dancer(id: id, name: name, lastUpdate: Date(), description: "\(name) description", coverImageURL: nil, profileImageURL: nil, genres: nil, studios: studios, youtubeURL: nil, instagramURL: nil)
        do {
            try Constant.dancerRef.document("\(name)").setData(from: dancer)
        } catch let error {
            print("Error writing dancer to Firestore: \(error)")
        }
    }
    
    func requestAllDancers() async throws -> [Dancer]? {
        do {
            let snapshot = try await Constant.dancerRef.getDocuments()
            
            return snapshot.documents.compactMap { document in
                try? document.data(as: Dancer.self)
            }
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func requestDancersByStudioName(name: String) async throws -> [Dancer]? {
        do {
            let snapshot = try await Constant.dancerRef.whereField("studios", arrayContains: name).getDocuments()
            
            return snapshot.documents.compactMap { document in
                try? document.data(as: Dancer.self)
            }
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func requestDancersBy(IDArray ids: [String]) async throws -> [Dancer]? {
        let snapshot = try await Constant.dancerRef.whereField("id", arrayContainsAny: ids).getDocuments()
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: Dancer.self)
        }
    }
}
