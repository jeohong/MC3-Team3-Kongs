//
//  WeekdayView.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/14.
//

import UIKit

class WeekdayView: UIView {
    //MARK: - Properties
    let weekdays = ["월", "화", "수", "목", "금", "토", "일"]
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 88
        stack.alignment = .leading
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    let separator: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        
        return line
    }()
    
    //MARK: - LifeCycle
    init(frame: CGRect, date: Date) {
        super.init(frame: frame)
        setLayout(monday: getMonday(myDate: date))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func setLayout(monday: Date) {
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        // stackView에 각각의 dayView 추가
        var date = monday
        for day in 0...6 {
            let cell = getDayView(weekday: weekdays[day], day: date.get(.day))
            stackView.addArrangedSubview(cell)
            
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        
        // 세로 구분선
        self.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 35).isActive = true
        separator.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -20).isActive = true
        separator.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    /// weekday와 day로 구성된 UIView를 반환합니다.
    private func getDayView(weekday: String, day: Int) -> UIView {
        let view = UIView()
        
        // 요일 label
        let weekdayLabel = UILabel()
        weekdayLabel.text = weekday
        weekdayLabel.textColor = .white
        weekdayLabel.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        view.addSubview(weekdayLabel)
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        weekdayLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        weekdayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // 날짜 label
        let dayLabel = UILabel()
        dayLabel.text = String(day)
        dayLabel.textColor = .white
        dayLabel.font = .systemFont(ofSize: 20.0, weight: .semibold)
        
        view.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }
    
    /// myDate가 속해 있는 주의 월요일을 반환합니다.
    private func getMonday(myDate: Date) -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: myDate)
        comps.weekday = 2 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
}

