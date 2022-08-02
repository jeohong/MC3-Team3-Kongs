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
    
    static let danceClass: DanceClass = DanceClass(id: "83349D56-0B2A-4488-BD34-66C64854DC50", name: "아프로 스타일 하우스 클래스", genres: nil, description: """
        춤추고 싶은 사람 누구나 참여 가능한
        힉스 비디오 클래스!
        
        *다채로운 영상을 남기고 싶은 각양각색의
        댄서나 일반인을 모집합니다.
        
        - 진행기간 :
        8월 1일 첫째주 부터 9월 9일까지 (6주간)
        
        - 정원 : 각 레슨마다 10명씩
        
        - 촬영 날짜: 9월 18일 일요일 오후 12시 이후
        """, isPopUp: false, startTime: Date(), endTime: Date() + (2 * 60 * 60), dancerID: "958DDBD8-689E-49D0-AC60-F7C0EC2611BC", dancerName: "Luke", studioID: "D643807C-DC29-482B-B2BD-0E9B5189E428", studioName: "HIGGS Studio")
}
