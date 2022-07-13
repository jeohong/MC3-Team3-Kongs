//
//  ScheduleViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class ScheduleViewController: BaseViewController {
    //MARK: - Properties
    
    let monthNumLable: UILabel = {
        let label = UILabel()
        label.text = String(Date().get(.month))
        label.textColor = .white
        label.font = .systemFont(ofSize: 30.0, weight: .semibold)
        
        return label
    }()
    
    let monthLable: UILabel = {
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    //MARK: - Helpers
    func configureUI() {
        //레이아웃 구성
        
        //상단 month 레이블
        view.addSubview(monthNumLable)
        monthNumLable.translatesAutoresizingMaskIntoConstraints = false
        monthNumLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        monthNumLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
        view.addSubview(monthLable)
        monthLable.translatesAutoresizingMaskIntoConstraints = false
        monthLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 78).isActive = true
        monthLable.leadingAnchor.constraint(equalTo: monthNumLable.trailingAnchor).isActive = true
        
        //좌측 week 뷰
        weekdayView = WeekdayView(frame: .zero, date: selectedDate)
        guard let weekdayView = weekdayView else {
            return
        }
        view.addSubview(weekdayView)
        weekdayView.translatesAutoresizingMaskIntoConstraints = false
        weekdayView.topAnchor.constraint(equalTo: monthNumLable.bottomAnchor, constant: 60).isActive = true
        weekdayView.leadingAnchor.constraint(equalTo: monthNumLable.leadingAnchor, constant: 10).isActive = true
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
