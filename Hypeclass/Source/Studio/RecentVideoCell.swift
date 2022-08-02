//
//  recentVideoCell.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/08/02.
//

import UIKit

class RecentVideoCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let playImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "play.fill")
        image.tintColor = .white
        
        return image
    }()
    
    private let videoThumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()

    static let recentVideoCellID = "RecentVideoCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(videoThumbnail)
        videoThumbnail.translatesAutoresizingMaskIntoConstraints = false
        videoThumbnail.heightAnchor.constraint(equalToConstant: 159.38).isActive = true
        videoThumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        videoThumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        videoThumbnail.addSubview(playImage)
        playImage.translatesAutoresizingMaskIntoConstraints = false
        playImage.topAnchor.constraint(equalTo: videoThumbnail.topAnchor, constant: 15.96).isActive = true
        playImage.trailingAnchor.constraint(equalTo: videoThumbnail.trailingAnchor, constant: -19.23).isActive = true
    }
}
