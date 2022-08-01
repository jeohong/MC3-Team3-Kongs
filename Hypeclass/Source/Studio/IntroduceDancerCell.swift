//
//  IntroduceViewController + DancerCell.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/08/01.
//

import UIKit

class IntroduceDancerCell: UICollectionViewCell {

    static let id = "GenreCell"
    
    // MARK: UIImageView로 수정
    
    private var imageView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .gray
        view.axis = .vertical
        view.alignment = .center
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
      
      // MARK: Initializer
      @available(*, unavailable)
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
      
      override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addArrangedSubview(genreLabel)
          
        NSLayoutConstraint.activate([
          imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
          imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
          imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
          imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        ])
      }
      
      override func prepareForReuse() {
        super.prepareForReuse()
        
         self.prepare(image: nil)
      }
      
    // MARK: UIImageView로 수정
    func prepare(image: UIStackView?) {
        self.imageView = image ?? UIStackView(frame: .zero)
    }
}

