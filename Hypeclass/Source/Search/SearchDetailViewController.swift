//
//  SearchDetailViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/13.
//

import UIKit
import Kingfisher

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
    
    let dancerTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        
        return table
    }()
    
    var searchStudio: [Studio]?
    var searchDancer: [Dancer]?
    var searchGenre: [Dancer]?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarUI()
        configureUI()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            await requestSearch(query: searchLabel.text ?? "")
        }
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
        
        self.view.addSubview(dancerTable)
        dancerTable.translatesAutoresizingMaskIntoConstraints = false
        dancerTable.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 5).isActive = true
        dancerTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dancerTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        dancerTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func configureNavigationBarUI() {
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.topItem?.title = searchLabel.text
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
    func configureTable() {
        dancerTable.delegate = self
        dancerTable.dataSource = self
        dancerTable.register(SearchDetailCell.self, forCellReuseIdentifier: SearchDetailCell.dancerCellID)
    }
    
    private func requestSearch(query: String) async {
        do {
            if searchStudio == nil && searchDancer == nil {
                IndicatorView.shared.show()
                IndicatorView.shared.showIndicator()
                async let searchStudio: [Studio]? = SearchManager.shared.requestQuery(queryString: query, mode: .name, category: .studio)
                async let searchDancer: [Dancer]? = SearchManager.shared.requestQuery(queryString: query, mode: .name, category: .dancer)
                async let searchGenre: [Dancer]? = SearchManager.shared.requestQuery(queryString: query, mode: .genres, category: .dancer)
                let searchResult: [Any]? = try await [searchStudio, searchDancer, searchGenre]
                IndicatorView.shared.dismiss()
                
                self.searchStudio = searchResult?[0] as! [Studio]?
                self.searchDancer = searchResult?[1] as! [Dancer]?
                self.searchGenre = searchResult?[2] as! [Dancer]?
            }
            dancerTable.reloadData()
        }
        catch {
            print(error)
        }
    }
    
    func fetchCell(cell: SearchDetailCell, index: Int, queryArray: [Any]?) {
        if let dancer = queryArray as? [Dancer] {
            cell.nameLabel.text = dancer[index].name
            cell.genreLabel.text = dancer[index].genres?.joined(separator: ", ")
            cell.classdayLabel.text = dancer[index].description
            cell.profileImage.kf.setImage(with: URL(string: "\(dancer[index].profileImageURL ?? "")"))
        } else if let studio = queryArray as? [Studio] {
            cell.nameLabel.text = studio[index].name
            cell.genreLabel.text = "좋아요 : \(studio[index].likes ?? 0)"
            cell.classdayLabel.text = studio[index].description
            cell.profileImage.kf.setImage(with: URL(string: "\(studio[index].profileImageURL ?? "")"))
        }
    }
}

//MARK: - TableView Extension

extension SearchDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Dancer 인지 Studio 인지 구분해서 전달
        if let cell = tableView.cellForRow(at: indexPath) as? SearchDetailCell {
            print(cell.nameLabel.text!)
            // 댄서 - 스튜디오 구분 로직 구현
            
        }
        
        // 구분 로직에 따른 전달값 수정
        
        let dancerDetailVC = DancerDetailViewController()
        // ☑️ TODO: 댄서 ID 건네주어야함.
        self.navigationController?.pushViewController(dancerDetailVC, animated: true)
    }
}

extension SearchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchDancer?.count ?? 0) + (searchStudio?.count ?? 0) + (searchGenre?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dancerTable.dequeueReusableCell(withIdentifier: SearchDetailCell.dancerCellID, for:indexPath) as! SearchDetailCell
        
        if !(searchDancer?.isEmpty)! {
            fetchCell(cell: cell, index: indexPath.row, queryArray: searchDancer)
        } else if !(searchStudio?.isEmpty)! {
            fetchCell(cell: cell, index: indexPath.row, queryArray: searchStudio)
        } else {
            fetchCell(cell: cell, index: indexPath.row, queryArray: searchGenre)
        }
        
        cell.backgroundColor = .clear
        
        return cell
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
