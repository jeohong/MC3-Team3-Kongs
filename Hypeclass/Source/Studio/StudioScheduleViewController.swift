//
//  StudioScheduleViewController.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/08/02.
//

import UIKit

class StudioScheduleViewController: BaseViewController {
    
    // MARK: - Properties
    
    var scheduleView: ScheduleItemView?
    
    var studioID: String?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        if studioID != nil {
            // scheduleView
            scheduleView = ScheduleItemView(frame: .zero, studioID: self.studioID!, date: Date())
            view.addSubview(scheduleView!)
            scheduleView?.translatesAutoresizingMaskIntoConstraints = false
            scheduleView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            scheduleView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26).isActive = true
            scheduleView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26).isActive = true
        }
    }
}

// MARK: - Preview

import SwiftUI

struct StudioScheduleViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = StudioScheduleViewController

    func makeUIViewController(context: Context) -> StudioScheduleViewController {
        return StudioScheduleViewController()
    }

    func updateUIViewController(_ uiViewController: StudioScheduleViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct StudioScheduleViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StudioScheduleViewControllerRepresentable()
    }
}
