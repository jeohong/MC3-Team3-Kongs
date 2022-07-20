//
//  Date.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

extension Date {
    init(year: Int, month: Int, day: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd"
        self = dateFormatter.date(from: "\(year):\(month):\(day)") ?? Date()
    }
    
    var text: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var detailText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    // MARK: 이미지 파일을 저장할 때 마땅한 이름이 없는 경우 현재 일시를 파일 이름으로 사용하기도 합니다.
    var fileName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmssSSS"
        return dateFormatter.string(from: self)
    }
    
    var relativeTime_abbreviated: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    //2022-01-11T08:18:09.000Z 에 해당하는 메서드 만들기
    
    // 캘린더의 컴포넌트를 가져오는 extension(eg. Date().get(.month) -> 오늘 날짜에 해당하는 월 반환)
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    // 같은 주의 월요일을 반환합니다.
    func mondayInWeek(at weekdayNum: Int, calendar: Calendar = Calendar.current) -> Date {
        var date = self
        if weekdayNum == 1 {
            date = calendar.date(byAdding: .day, value: -7, to: date)!
        }
        var comps = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        comps.weekday = 2
        return calendar.date(from: comps)!
    }
    
    // 현재 주의 해당 월을 반환합니다.
    func monthString(calendar: Calendar = Calendar.current) -> String {
        let monday = self.mondayInWeek(at: self.get(.weekday))

        for idx in 0...6 {
            let date = calendar.date(byAdding: .day, value: idx, to: monday)
            
            if date!.get(.day) == 1 {
                return String(date!.get(.month))
            }
        }
        return String(monday.get(.month))
    }
}
