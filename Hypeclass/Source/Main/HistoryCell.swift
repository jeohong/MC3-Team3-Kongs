//
//  HistoryCell.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/17.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let chip: UIView = {
        let chip = UIView()
        chip.backgroundColor = .gray
        
        return chip
    }()
    
    let searchHistory: UILabel = {
        let searchHistory = UILabel()
        searchHistory.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        searchHistory.textColor = .gray
        
        return searchHistory
    }()
    
    let cancelBtn: UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelBtn.tintColor = .gray
        
        return cancelBtn
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
        contentView.addSubview(searchHistory)
        searchHistory.translatesAutoresizingMaskIntoConstraints = false
        searchHistory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9).isActive = true
        searchHistory.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        searchHistory.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(cancelBtn)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cancelBtn.leadingAnchor.constraint(equalTo: searchHistory.trailingAnchor, constant: 12).isActive = true
    }
}
