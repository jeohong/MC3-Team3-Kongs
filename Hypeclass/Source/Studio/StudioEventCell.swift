//
//  StudioEventCell.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/02.
//

import UIKit

class StudioEventCell: UITableViewCell {
    
    //MARK: - Properties
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아프로 스타일 하우스 댄스"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "08/01 ~ 09/09"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        self.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            coverImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor),
        ])
        
        self.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
}
