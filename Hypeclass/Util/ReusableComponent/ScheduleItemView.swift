//
//  ScheduleItemView.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/08/01.
//

import UIKit

protocol ScheduleItemDelegate {
    func scheduleDidSelect(schedule: DanceClass)
}

class ScheduleItemView: UIView {
    
    // MARK: - Properties
    
    private let popUpTag: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = .accent

        return view
    }()

    private let popUpLabel: UILabel = {
        let label = UILabel()
        label.text = "POP-UP"
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)

        return label
    }()
    
    private var studioID: String?
    
    private var dancerID: String?
    
    private var selectedDate: Date?
    
    private let scheduleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        cv.backgroundColor = .container
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    private let separator = Separator()
    
    private let weekdayCellID = "weekday"
    private let scheduleCellID = "schedule"
    
    private var allClasses: [DanceClass]?
    
    private var weekSchedules: [[DanceClass]] = [
        [], [], [], [], [], [], []
    ]
    
    var delegate: ScheduleItemDelegate?

    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(frame: CGRect, studioID: String, date: Date) {
        super.init(frame: .zero)
        
        self.backgroundColor = .background
        self.studioID = studioID
        self.selectedDate = date
        Task {
            await requestDanceClasses()
            configureUI()
        }
    }
    
    required init(frame: CGRect, dancerID: String, date: Date) {
        super.init(frame: .zero)
        
        self.backgroundColor = .background
        self.dancerID = dancerID
        self.selectedDate = date
        Task {
            await requestDanceClasses()
            configureUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureUI() {
        // POP-UP Tag
        self.addSubview(popUpLabel)
        popUpLabel.translatesAutoresizingMaskIntoConstraints = false
        popUpLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        popUpLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        self.addSubview(popUpTag)
        popUpTag.translatesAutoresizingMaskIntoConstraints = false
        popUpTag.centerYAnchor.constraint(equalTo: popUpLabel.centerYAnchor).isActive = true
        popUpTag.trailingAnchor.constraint(equalTo: popUpLabel.leadingAnchor, constant: -3).isActive = true
        popUpTag.heightAnchor.constraint(equalToConstant: 10).isActive = true
        popUpTag.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        // scheduleCollectionView
        scheduleCollectionView.register(WeekdayCell.self, forCellWithReuseIdentifier: weekdayCellID)
        scheduleCollectionView.register(ScheduleItemCell.self, forCellWithReuseIdentifier: scheduleCellID)
        scheduleCollectionView.delegate = self
        scheduleCollectionView.dataSource = self
        
        self.addSubview(scheduleCollectionView)
        scheduleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        scheduleCollectionView.topAnchor.constraint(equalTo: popUpLabel.bottomAnchor, constant: 10).isActive = true
        scheduleCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scheduleCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scheduleCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        let maxNum = weekSchedules.max { $0.count < $1.count }
        if maxNum?.count ?? 0 < 1 { scheduleCollectionView.heightAnchor.constraint(equalToConstant: 145).isActive = true }
        else { scheduleCollectionView.heightAnchor.constraint(equalToConstant: 60 + 75 * CGFloat(maxNum!.count) + 10).isActive = true }
                
        // Separator
        self.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: scheduleCollectionView.topAnchor, constant: 60).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    private func requestDanceClasses() async {
        do {
            if (studioID != nil) { allClasses = try await DanceClassManager.shared.requestDanceClassBy(studioID: self.studioID ?? "") }
            else { allClasses = try await DanceClassManager.shared.requestDanceClassBy(dancerID: self.dancerID ?? "") }
        }
        catch {
            print(error)
        }
        
        let monday = selectedDate!.mondayInWeek(at: selectedDate!.get(.weekday))
        let cal = Calendar.current
        
        for idx in 0...6 {
            let date = cal.date(byAdding: .day, value: idx, to: monday)
            weekSchedules[idx] = []
            
            let dancerSchedules = allClasses!.filter { cal.isDate(date!, inSameDayAs: $0.startTime!) }
            dancerSchedules.forEach { schedule in
                weekSchedules[idx].append(schedule)
            }
            weekSchedules[idx] = weekSchedules[idx].sorted(by: { $0.startTime! < $1.startTime! })
        }
    }
}

// MARK: - UICollectionView Extension

extension ScheduleItemView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weekdayCellID, for: indexPath) as! WeekdayCell
            cell.weekdayLabel.text = Weekday.allCases[indexPath.section].rawValue
            cell.dayLabel.text = cell.dayString(date: selectedDate!, dayNum: indexPath.section)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellID, for: indexPath) as! ScheduleItemCell
            let schedule = weekSchedules[indexPath.section][indexPath.item - 1]
            cell.dancerNameLabel.text = schedule.dancerName
            cell.popUpTag.isHidden = !(schedule.isPopUp ?? false)
            cell.startTimeLabel.text = schedule.startTime?.hourMinText ?? ""
            cell.endTimeLabel.text = schedule.endTime?.hourMinText ?? ""
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekSchedules[section].count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != 0 {
            let schedule = weekSchedules[indexPath.section][indexPath.item - 1]
            delegate?.scheduleDidSelect(schedule: schedule)
        }
    }
}

extension ScheduleItemView: UICollectionViewDelegate {
}

extension ScheduleItemView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 55, height: 59)
        } else {
            return CGSize(width: 55, height: 65)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
}

