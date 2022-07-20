//
//  SearchDetailViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/13.
//

import UIKit

class SearchDetailViewController: BaseViewController {
    
    //MARK: - Properties
    let searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    let separator = Separator()
    
    let cancelButton: UIButton = {
        let img = UIImage(systemName: "xmark.circle.fill")
        let cancelBtn = UIButton()
        cancelBtn.setImage(img, for: .normal)
        cancelBtn.tintColor = .gray
        
        return cancelBtn
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarUI()
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        // Separator Layout
        self.view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18).isActive = true
    }
    
    func configureNavigationBarUI() {
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.topItem?.title = searchLabel.text
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
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
