//
//  ScheduleViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class ScheduleViewController: BaseViewController {
    //MARK: - Properties
    
    let monthNumLabel: UILabel = {
        let label = UILabel()
        label.text = String(Date().get(.month))
        label.textColor = .white
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        
        return label
    }()
    
    var selectedDate: Date = {
        return Date()
    }()
    
    var weekdayView: WeekdayView?
    
    let previousBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "chevron.backward")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(fetchLastWeek), for: .touchUpInside)
        
        return btn
    }()
    
    let nextBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "chevron.forward")
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(fetchNextWeek), for: .touchUpInside)
        
        return btn
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func fetchLastWeek() {
        weekdayView!.removeFromSuperview()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate)!
        selectedDate = modifiedDate
        weekdayView = WeekdayView(frame: .zero, date: selectedDate)
        configureUI()
    }
    
    @objc func fetchNextWeek() {
        weekdayView!.removeFromSuperview()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)!
        selectedDate = modifiedDate
        weekdayView = WeekdayView(frame: .zero, date: selectedDate)
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        //레이아웃 구성
        
        //상단 month 레이블
        monthNumLabel.text = String(selectedDate.get(.month))
        view.addSubview(monthNumLabel)
        monthNumLabel.translatesAutoresizingMaskIntoConstraints = false
        monthNumLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        monthNumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
        view.addSubview(monthLabel)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 78).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: monthNumLabel.trailingAnchor).isActive = true
        
        //<> 버튼
        view.addSubview(nextBtn)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(previousBtn)
        previousBtn.translatesAutoresizingMaskIntoConstraints = false
        previousBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        previousBtn.trailingAnchor.constraint(equalTo: nextBtn.leadingAnchor, constant: -5).isActive = true
        
        //좌측 week 뷰
        weekdayView = WeekdayView(frame: .zero, date: selectedDate)
        guard let weekdayView = weekdayView else {
            return
        }
        view.addSubview(weekdayView)
        weekdayView.translatesAutoresizingMaskIntoConstraints = false
        weekdayView.topAnchor.constraint(equalTo: monthNumLabel.bottomAnchor, constant: 60).isActive = true
        weekdayView.leadingAnchor.constraint(equalTo: monthNumLabel.leadingAnchor, constant: 10).isActive = true
    }
    
}

//MARK: - Preview
import SwiftUI

struct ScheduleViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScheduleViewController

    func makeUIViewController(context: Context) -> ScheduleViewController {
        return ScheduleViewController()
    }

    func updateUIViewController(_ uiViewController: ScheduleViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct ScheduleViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ScheduleViewControllerRepresentable()
    }
}
