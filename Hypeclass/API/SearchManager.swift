//
//  SearchManager.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/26.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class SearchManager {
    static let shared = SearchManager()
    
    func requestSearchDancer(dancerSearch: String) async throws -> [Dancer]? {
        let snapshot = try await Constant.dancerRef.whereField("name", isGreaterThanOrEqualTo: dancerSearch).getDocuments()
        
        let searchDancer = snapshot.documents.compactMap { document in
            try? document.data(as: Dancer.self)
        }
        
        return searchDancer
    }
    
    func requestSearchStudio(studioSearch: String) async throws -> [Studio]? {
        let snapshot = try await Constant.studioRef.whereField("name", isGreaterThan: studioSearch).getDocuments()
        
        let searchStudio =  snapshot.documents.compactMap { document in
            try? document.data(as: Studio.self)
        }
        
        return searchStudio
    }
    
    func requestSearchGenre(genreSearch: String) async throws -> [Dancer]? {
        let snapshot = try await Constant.dancerRef.whereField("genres", arrayContains: genreSearch).getDocuments()
        
        let searchGenre = snapshot.documents.compactMap { document in
            try? document.data(as: Dancer.self)
        }
        
        return searchGenre
    }
}
