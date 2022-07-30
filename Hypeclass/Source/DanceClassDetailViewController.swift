//
//  DanceClassDetailViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class DanceClassDetailViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아프로 스타일 하우스 클래스"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        
        return label
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        //레이아웃 구성
        
        view.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        ])
        
        
    }
}

//MARK: - Preview
import SwiftUI

struct DanceClassDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = DanceClassDetailViewController

    func makeUIViewController(context: Context) -> DanceClassDetailViewController {
        return DanceClassDetailViewController()
    }

    func updateUIViewController(_ uiViewController: DanceClassDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct DanceClassDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        DanceClassDetailViewControllerRepresentable()
    }
}
