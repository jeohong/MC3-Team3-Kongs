//
//  MainTabController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class MainTabController: UITabBarController {
    //MARK: - Properties
    let divider: CALayer = {
        let topline = CALayer()
        topline.frame = CGRect(x: 0, y: -0.5, width: Device.width, height: 0.5)
        topline.backgroundColor = UIColor(hex: 0xD8D8D8).cgColor
        return topline
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        uiTabBarSetting()
        
//        DanceClassManager.shared.createDanceClass(model: DanceClass(id: UUID().uuidString, name: "빈 힙합 정규 클래스", genres: nil, description: "q", isPopUp: false, coverImageURL: "https://firebasestorage.googleapis.com/v0/b/hypeclass-95cdb.appspot.com/o/dancer%2Fcover%2FBinnn_Cover.png?alt=media&token=bd519f83-4761-4730-b454-a4addd956a6e", startTime: Date(), endTime: Date() + (2 * 60 * 60), dancerID: "58bac0e0-4bf5-4e72-95b0-16e873a55c8f", dancerName: "Binn", studioID: "8bc63898-aec4-44d4-8329-4bc9b52b98cd", studioName: "Urban Play"))
    }
    
    //MARK: - Helpers
    func configureViewControllers() {
        let main = MainViewController()
        main.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        let schedule = ScheduleViewController()
        schedule.tabBarItem = UITabBarItem(title: "스케쥴", image: UIImage(systemName: "calendar"), tag: 1)
        let subscription = SubscriptionViewController()
        subscription.tabBarItem = UITabBarItem(title: "구독", image: UIImage(systemName: "star"), tag: 2)
    
        viewControllers = [main, schedule, subscription]
    }
    
    func uiTabBarSetting() {
        if #available(iOS 15.0, *){
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .background
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        //디바이더 추가
        self.tabBar.layer.addSublayer(divider)
        tabBar.tintColor = UIColor(hex: 0xD2D6D7)
    }
}
