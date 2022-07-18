//
//  ViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import UIKit

class MainViewController: BaseViewController {
    //MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서들의 클래스를 확인해보세요"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        //MARK: - TODO: func textRect(라벨 박스 크기 확인)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchButton: UIButton = {
        var config = UIButton.Configuration.gray()
        config.buttonSize = .large
        config.titleAlignment = .leading
        config.title = "찾고자 하는 댄서나 장르를 검색해보세요"
        config.background = .listSidebarCell()
        //MARK: - 돋보기 이미지 구성
        
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.baseForegroundColor = UIColor(hex: 0x7A7A7A)
        config.baseBackgroundColor = UIColor(hex: 0x2D2C38)
        let button = UIButton (
            configuration: config, primaryAction: UIAction(handler: { _ in
            print("MainViewController -> SearchViewController")
            //MARK: TO_DO: searchView 연결
//            let searchViewController = SearchViewController()
//            UINavigationController?.pushViewController(searchViewController, animated: true)
            })
        )
        button.contentHorizontalAlignment = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(searchButton)
        // MARK: - AutoLayout
        
        titleConstraint()
        searchButtonConstraint()
    }
    //MARK: - Selectors
    //MARK: - Helpers
    private func titleConstraint() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25).isActive = true
    }
    
    private func searchButtonConstraint() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.searchButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120).isActive = true
        self.searchButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 25).isActive = true
        self.searchButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -25).isActive = true
    }
}


//MARK: - Preview
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MainViewController

    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }

    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
