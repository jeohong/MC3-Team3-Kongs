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
        topline.frame = CGRect(x: 0, y: -1, width: Device.width, height: 1)
        topline.backgroundColor = UIColor.gray.cgColor
        return topline
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        uiTabBarSetting()
    }
    
    //MARK: - Helpers
    func configureViewControllers() {
        let main = ViewController()
        main.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let schedule = ScheduleViewController()
        schedule.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(systemName: "square"), tag: 1)
        let subscription = SubscriptionViewController()
        subscription.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "person"), tag: 2)
    
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
    }
}
