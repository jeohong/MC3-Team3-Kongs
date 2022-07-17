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
    let historyTitle: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    let historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let historyCellID = "history"
    
    var historyList = [String]()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
        configureUI()
        setSearchBar()
        historyCollectionView.register(HistoryCell.self, forCellWithReuseIdentifier: historyCellID)
        historyCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        historyList = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []
        historyCollectionView.reloadData()
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
        
        self.view.addSubview(historyTitle)
        historyTitle.translatesAutoresizingMaskIntoConstraints = false
        historyTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 26).isActive = true
        historyTitle.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 26).isActive = true
        
        self.view.addSubview(historyCollectionView)
        historyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        historyCollectionView.topAnchor.constraint(equalTo: historyTitle.bottomAnchor, constant: 13).isActive = true
        historyCollectionView.leadingAnchor.constraint(equalTo: historyTitle.leadingAnchor).isActive = true
        historyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -637).isActive = true
        historyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
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
        if var searchHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") {
            searchHistory.insert(searchText, at: 0)
            
            if(searchHistory.count > 10) { searchHistory.remove(at: 10) }
            UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
        } else {
            var newHistory = [String]()
            newHistory.append(searchText)
            UserDefaults.standard.set(newHistory, forKey: "SearchHistory")
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

//MARK: - CollectionView Extension

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = historyCollectionView.dequeueReusableCell(withReuseIdentifier: historyCellID, for: indexPath) as! HistoryCell
        cell.searchHistory.text = "\(historyList[indexPath.row])"
        return cell
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
