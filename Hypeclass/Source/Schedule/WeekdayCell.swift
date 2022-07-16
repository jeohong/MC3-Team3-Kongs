//
//  WeekdayCell.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/15.
//

import UIKit

class WeekdayCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func setLayout() {
        // 요일 label
        contentView.addSubview(weekdayLabel)
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        weekdayLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        weekdayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        // 날짜 label
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    /// date가 속해 있는 주의 날짜를 반환합니다.
    func dayString(date: Date, dayNum: Int) -> String {
        var myDate = date
        if dayNum == 6 {
            myDate = Calendar.current.date(byAdding: .day, value: 7, to: date)!
        }
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: myDate)
        comps.weekday = 7 * ((dayNum + 2) / 7) + (dayNum + 2) % 7
        return String(cal.date(from: comps)!.get(.day))
    }
}
