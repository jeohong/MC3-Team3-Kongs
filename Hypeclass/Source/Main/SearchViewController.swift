//
//  SearchViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/13.
//

import UIKit

class SearchViewController: BaseViewController {
    //MARK: - Properties
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "찾고자 하는 댄서나 장르를 검색하세요."
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        
        return searchBar
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
        configureUI()
        
        searchBar.delegate = self
    }
    
    //MARK: - Selectors
    //MARK: - Helpers
    func configureUI() {
        //레이아웃 구성
    }
    
    func setNavigationBarUI() {
        self.navigationItem.titleView = searchBar
    }
}

// SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    // SearchButton Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        let searchDetailVC = SearchDetailViewController()
        searchDetailVC.searchBar.text = searchText
        self.navigationController?.pushViewController(searchDetailVC, animated: true)
        
    }
}

//MARK: - Preview
import SwiftUI

struct SearchViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SearchViewController
    
    func makeUIViewController(context: Context) -> SearchViewController {
        return SearchViewController()
    }
    
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct SearchViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SearchViewControllerRepresentable()
    }
}
