//
//  UIPageViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/04.
//

import UIKit

extension UIPageViewController { // 스크롤 안되도록 함.
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
