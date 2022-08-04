//
//  ScheduleItemCell.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/08/01.
//

import UIKit

class ScheduleItemCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let popUpTag: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3.5
        view.clipsToBounds = true
        view.backgroundColor = .accent

        return view
    }()
    
    let dancerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 11.0, weight: .light)
        
        return label
    }()
    
    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 11.0, weight: .light)
        
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureLayout() {
        // POP-UP TAG
        contentView.addSubview(popUpTag)
        popUpTag.translatesAutoresizingMaskIntoConstraints = false
        popUpTag.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        popUpTag.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3).isActive = true
        popUpTag.heightAnchor.constraint(equalToConstant: 7).isActive = true
        popUpTag.widthAnchor.constraint(equalToConstant: 7).isActive = true
        
        // dancerNameLabel
        contentView.addSubview(dancerNameLabel)
        dancerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dancerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
        dancerNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        // startTimeLabel
        contentView.addSubview(startTimeLabel)
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        startTimeLabel.topAnchor.constraint(equalTo: dancerNameLabel.bottomAnchor, constant: 7).isActive = true
        startTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        // endTimeLabel
        contentView.addSubview(endTimeLabel)
        endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 3).isActive = true
        endTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
