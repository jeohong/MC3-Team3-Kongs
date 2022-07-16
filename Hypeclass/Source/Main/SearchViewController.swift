//
//  SearchViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/13.
//

import UIKit

class SearchViewController: BaseViewController {
    
    //MARK: - Properties
    
    let searchBar = SearchBar()
    let separator = Separator()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
        configureUI()
        setSearchBar()
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
    
    func setSearchBar() {
        searchBar.delegate = self
        
        searchBar.placeholder = "찾고자 하는 댄서나 장르를 검색하세요."
        searchBar.becomeFirstResponder()
    }
    
    // Navigation 화면 전환
    func pushSearchDetailView(_ searchText: String) {
        let searchDetailVC = SearchDetailViewController()
        searchDetailVC.searchBar.text = searchText
        self.navigationController?.pushViewController(searchDetailVC, animated: true)
    }
    
    // SearchHistory를 UserDefault에 저장
    func storeSearchHistory(_ searchText: String) {
        if var searchHistory = UserDefaults.standard.stringArray(forKey: "\(searchHistory)") {
            searchHistory.insert(searchText, at: 0)
            
            if(searchHistory.count > 10) { searchHistory.remove(at: 10) }
            UserDefaults.standard.set(searchHistory, forKey: "\(searchHistory)")
        } else {
            var newHistory = [String]()
            newHistory.append(searchText)
            UserDefaults.standard.set(newHistory, forKey: "\(searchHistory)")
        }
    }
}

//MARK: - SearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    // SearchButton Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        storeSearchHistory(searchText)
        pushSearchDetailView(searchText)
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
