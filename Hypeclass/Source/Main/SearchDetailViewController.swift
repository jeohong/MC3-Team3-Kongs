//
//  SearchDetailViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/13.
//

import UIKit

class SearchDetailViewController: BaseViewController {
    
    //MARK: - Properties
    
    let searchBar = SearchBar()
    let separator = Separator()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        // Separator Layout
        self.view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18).isActive = true
    }
    
    func setNavigationBarUI() {
        self.navigationItem.titleView = searchBar
    }
}

//MARK: - Preview

import SwiftUI

struct SearchDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchDetailViewController
    
    func makeUIViewController(context: Context) -> SearchDetailViewController {
        return SearchDetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: SearchDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct SearchDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SearchDetailViewControllerRepresentable()
    }
}
