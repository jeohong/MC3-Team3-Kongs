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
    
    let stackViews: [UIStackView] = [
        UIStackView(), UIStackView(), UIStackView(), UIStackView(), UIStackView(), UIStackView(), UIStackView()
    ]
    
    let scheduleCellID = "cell"
    
    let scheduleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .background

        return cv
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    /// 지난 주 날짜의 weekdayView로 변경합니다.
    @objc func fetchLastWeek() {
        removeAllSubViews()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate)!
        selectedDate = modifiedDate
        weekdayView = WeekdayView(frame: .zero, date: selectedDate)
        scheduleCollectionView.reloadData()
        configureUI()
    }
    
    /// 다음 주 날짜의 weekdayView로 변경합니다.
    @objc func fetchNextWeek() {
        removeAllSubViews()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)!
        selectedDate = modifiedDate
        weekdayView = WeekdayView(frame: .zero, date: selectedDate)
        scheduleCollectionView.reloadData()
        configureUI()
    }
    
    /// 댄서 디테일 뷰 페이지로 이동합니다.
    @objc func moveToDetailView(sender: UIButton) {
        // TODO: push detailViewController with sender.tag
        print("moveToDetailView(): \(sender.tag)")
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
        
        //scheduleCollectionView
        addBtnToStackView()
        scheduleCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: scheduleCellID)
        scheduleCollectionView.dataSource = self
        scheduleCollectionView.delegate = self

        view.addSubview(scheduleCollectionView)
        scheduleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        scheduleCollectionView.topAnchor.constraint(equalTo: monthNumLabel.bottomAnchor, constant: 40).isActive = true
        scheduleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95).isActive = true
        scheduleCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90).isActive = true
        scheduleCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    /// 클래스 데이터를 이용해 StackView에 각각 해당하는 ScheduleButton을 추가합니다.
    func addBtnToStackView() {
        for stackView in stackViews {
            for subView in stackView.subviews {
                subView.removeFromSuperview()
            }
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 20
            stackView.distribution = .equalSpacing
            
            // TODO: Should be replaced to real data management!
            for n in 0...3 {
                // TODO: Fetch class information here
                let dancerName = "NARAE"
                let studioName = "1million"
                let startTime = "18:00"
                let endTime = "20:00"
                
                let btn = ScheduleButton(frame: .zero, dancerName: dancerName, studioName: studioName, startTime: startTime, endTime: endTime)
                btn.tag = n // TODO: DanceClass id를 Int로 변환
                btn.addTarget(self, action: #selector(moveToDetailView), for: .touchUpInside)
                stackView.addArrangedSubview(btn)
            }
        }
    }
    
    /// ScheduleViewController의 모든 서브 뷰를 삭제합니다.
    func removeAllSubViews() {
        for subView in view.subviews{
            subView.removeFromSuperview()
        }
    }
    
}

//MARK: - Extension
extension ScheduleViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleCellID, for: indexPath)
        cell.contentView.addSubview(stackViews[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stackViews.count
    }
}

extension ScheduleViewController: UICollectionViewDelegate {
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // TODO: width -> 가장 많은 아이템을 가진 스택 뷰의 width
        let width: CGFloat = 200 * 4
        let height: CGFloat = (collectionView.frame.height / 8)

        return CGSize(width: width, height: height)
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
