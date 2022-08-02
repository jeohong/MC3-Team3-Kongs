//
//  ScheduleView.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/19.
//

import UIKit

class ScheduleView: UIView {
    
    // MARK: - Properties
    
    var model: DanceClass?
    
    private let dancerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    
    private let classInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13.0, weight: .regular)
        return label
    }()
    
    // MARK: - LifeCycle
    
    required init(frame: CGRect, viewWidth: CGFloat, model: DanceClass) {
        super.init(frame: .zero)
        self.model = model
        dancerNameLabel.text = model.dancerName
        classInfoLabel.text = "\(model.startTime?.hourMinText ?? "")~\(model.endTime?.hourMinText ?? "")  |  \(model.studioName ?? "")"
        
        configureUI(width: viewWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI(width: CGFloat) {
        // ScheduleView
        self.backgroundColor = .background
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.isUserInteractionEnabled = true
        
        // dancerNameLabel
        self.addSubview(dancerNameLabel)
        dancerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dancerNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        dancerNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        
        // classInfoLabel
        classInfoLabel.numberOfLines = 1
        classInfoLabel.allowsDefaultTighteningForTruncation = true
        classInfoLabel.widthAnchor.constraint(equalToConstant: width - 12 * 2).isActive = true
        
        self.addSubview(classInfoLabel)
        classInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        classInfoLabel.topAnchor.constraint(equalTo: dancerNameLabel.bottomAnchor).isActive = true
        classInfoLabel.leadingAnchor.constraint(equalTo: dancerNameLabel.leadingAnchor).isActive = true
        classInfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
    }
}
