//
//  MainStudioCell.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/29.
//

import UIKit

class MainStudioCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var studioImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        return imageView
    }()
    
    let studioNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureLayout() {
        // studioImage
        contentView.addSubview(studioImage)
        studioImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studioImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            studioImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            studioImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            studioImage.heightAnchor.constraint(equalTo: studioImage.widthAnchor)
        ])

        // studioNameLabel
        contentView.addSubview(studioNameLabel)
        studioNameLabel.translatesAutoresizingMaskIntoConstraints = false
        studioNameLabel.numberOfLines = 1
        studioNameLabel.allowsDefaultTighteningForTruncation = true
        NSLayoutConstraint.activate([
            studioNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            studioNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            studioNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
