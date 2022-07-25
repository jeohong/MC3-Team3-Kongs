//
//  WeeklyScheduleCell.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/20.
//

import UIKit

class WeeklyScheduleCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let studioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tildeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        label.text = "~"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func setupStackView() {
        timeStackView.addArrangedSubview(startTimeLabel)
        timeStackView.addArrangedSubview(tildeLabel)
        timeStackView.addArrangedSubview(endTimeLabel)
    }
    
    private func setLayout() {
        // 요일 label
        contentView.addSubview(weekdayLabel)
        contentView.addSubview(dayLabel)
        contentView.addSubview(stackBackgroundView)
        stackBackgroundView.addSubview(studioLabel)
        stackBackgroundView.addSubview(timeStackView)

        NSLayoutConstraint.activate([
            weekdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weekdayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            weekdayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            dayLabel.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor, constant: 1),
            dayLabel.centerXAnchor.constraint(equalTo: weekdayLabel.centerXAnchor),
            
            stackBackgroundView.topAnchor.constraint(equalTo: weekdayLabel.bottomAnchor, constant: 0),
            stackBackgroundView.centerXAnchor.constraint(equalTo: dayLabel.centerXAnchor),

            studioLabel.topAnchor.constraint(equalTo: stackBackgroundView.topAnchor, constant: 30),
            studioLabel.centerXAnchor.constraint(equalTo: stackBackgroundView.centerXAnchor),

            timeStackView.topAnchor.constraint(equalTo: studioLabel.topAnchor, constant: 30),
            timeStackView.centerXAnchor.constraint(equalTo: studioLabel.centerXAnchor)
        ])
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
