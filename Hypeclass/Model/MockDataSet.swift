//
//  MockDataSet.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/17.
//

import Foundation

class MockDataSet {
    //댄서 클래스 mock data 리스트
    static let danceClasses: [DanceClass] = {
        do {
            if let filePath = Bundle.main.path(forResource: "DanceClass", ofType: "json") {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let tableData = try decoder.decode([DanceClass].self, from: data)
                return tableData
            } else {
                print("ERROR: can't find filepath for dancer class mockData")
            }
        } catch {
            print("error: \(error)")
        }
        return []
    }()
    
    //댄서 mock data 리스트
    static let dancers: [Dancer] = {
        do {
            if let filePath = Bundle.main.path(forResource: "Dancer", ofType: "json") {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let tableData = try decoder.decode([Dancer].self, from: data)
                return tableData
            } else {
                print("ERROR: can't find filepath for dancer class mockData")
            }
        } catch {
            print("error: \(error)")
        }
        return []
    }()
}
