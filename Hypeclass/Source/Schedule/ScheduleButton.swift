//
//  ScheduleButton.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/14.
//

import UIKit

class ScheduleButton: UIButton {
    init(frame: CGRect, dancerName: String, studioName: String, startTime: String, endTime: String) {
        super.init(frame: frame)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .background
        config.background.cornerRadius = 10
        config.background.strokeColor = .white
        config.background.strokeWidth = 1
        
        var nameAttr = AttributedString.init("\(dancerName)")
        nameAttr.font = .systemFont(ofSize: 18.0, weight: .bold)
        config.attributedTitle = nameAttr
        config.titlePadding = 4
        
        var detailAttr = AttributedString.init("\(startTime)~\(endTime)  |  \(studioName)")
        detailAttr.font = .systemFont(ofSize: 13.0, weight: .regular)
        config.attributedSubtitle = detailAttr
        
        config.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
