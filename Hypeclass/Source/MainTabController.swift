//
//  MainTabController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
    }

    func configureViewControllers() {
    
        let main = ViewController()
        main.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let schedule = ScheduleViewController()
        schedule.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(systemName: "square"), tag: 1)
        let subscription = SubscriptionViewController()
        subscription.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "person"), tag: 2)
     
        viewControllers = [main, schedule, subscription]

    }
}
