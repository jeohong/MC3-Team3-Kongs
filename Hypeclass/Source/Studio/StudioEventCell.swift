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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        contentView.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: coverImageView.trailingAnchor),
        ])
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
}
