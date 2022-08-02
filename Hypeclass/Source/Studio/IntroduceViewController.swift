//
//  IntroduceViewController.swift
//  Hypeclass
//
//  Created by Hong jeongmin on 2022/07/30.
//

import UIKit

class IntroduceViewController: BaseViewController {
    
    //MARK: - Properties
    
    // 지오 PR 올라오면 데이터 받아서 처리 ( 샘플 코드 )
    var studioInfo: Studio? = Studio(id: "123", name: "Apple", description: "안녕하세요 반갑습니다 ㅋ_ㅋ", instagramURL: "www.naver.com", youtubeURL: nil, dancers: ["Chikong", "Luke", "Ian", "Jio", "Nia", "Raven"], likes: 2)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스튜디오 소개"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.sizeToFit()
        label.numberOfLines = 0
        
        return label
    }()
    
    private let InstructorsLabel: UILabel = {
        let label = UILabel()
        label.text = "Instructors"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let instructorsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 9.06
        layout.minimumInteritemSpacing = 9.06
        layout.itemSize = CGSize(width: 78, height: 78)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    private let recentVideoLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 영상"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let recentVideoTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureInstructorsCollection()
        configurerecentVideoTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        introduceLabel.text = studioInfo?.description
        instructorsCollection.reloadData()
        recentVideoTable.reloadData()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 31).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        
        self.view.addSubview(introduceLabel)
        introduceLabel.translatesAutoresizingMaskIntoConstraints = false
        introduceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        introduceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        introduceLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        
        self.view.addSubview(InstructorsLabel)
        InstructorsLabel.translatesAutoresizingMaskIntoConstraints = false
        InstructorsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        InstructorsLabel.topAnchor.constraint(equalTo: introduceLabel.bottomAnchor, constant: 27).isActive = true
        
        self.view.addSubview(instructorsCollection)
        instructorsCollection.translatesAutoresizingMaskIntoConstraints = false
        instructorsCollection.topAnchor.constraint(equalTo: InstructorsLabel.bottomAnchor, constant: 10).isActive = true
        instructorsCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        instructorsCollection.heightAnchor.constraint(equalToConstant: 78).isActive = true
        instructorsCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        instructorsCollection.contentInset = UIEdgeInsets(top: 0, left: 31, bottom: 0, right: 0)
        
        self.view.addSubview(recentVideoLabel)
        recentVideoLabel.translatesAutoresizingMaskIntoConstraints = false
        recentVideoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        recentVideoLabel.topAnchor.constraint(equalTo: instructorsCollection.bottomAnchor, constant: 27).isActive = true
        
        self.view.addSubview(recentVideoTable)
        recentVideoTable.translatesAutoresizingMaskIntoConstraints = false
        recentVideoTable.topAnchor.constraint(equalTo: recentVideoLabel.bottomAnchor, constant: 14).isActive = true
        recentVideoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.09).isActive = true
        recentVideoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -11).isActive = true
        recentVideoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureInstructorsCollection() {
        instructorsCollection.register(IntroduceDancerCell.self, forCellWithReuseIdentifier: IntroduceDancerCell.id)
        instructorsCollection.dataSource = self
        instructorsCollection.delegate = self
    }
    
    func configurerecentVideoTable() {
        recentVideoTable.register(RecentVideoCell.self, forCellReuseIdentifier: RecentVideoCell.recentVideoCellID)
        recentVideoTable.dataSource = self
        recentVideoTable.delegate = self
    }
}

// MARK: - UICollectionView Extension

extension IntroduceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("IntroduceViewController => DancerDetailViwe ( tranfer :  \((studioInfo?.dancers?[indexPath.row])!))")
    }
}

extension IntroduceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return studioInfo?.dancers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroduceDancerCell.id, for: indexPath) as! IntroduceDancerCell
        cell.genreLabel.text = studioInfo?.dancers?[indexPath.row]
        
        return cell
    }
}

//MARK: - UITableView Extension

extension IntroduceViewController: UITableViewDelegate {
    
}

extension IntroduceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentVideoTable.dequeueReusableCell(withIdentifier: RecentVideoCell.recentVideoCellID, for:indexPath) as! RecentVideoCell
        
        return cell
    }
}

//MARK: - Preview
import SwiftUI

struct IntroduceViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = IntroduceViewController
    
    func makeUIViewController(context: Context) -> IntroduceViewController {
        return IntroduceViewController()
    }
    
    func updateUIViewController(_ uiViewController: IntroduceViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct IntroduceViewControllerPreview: PreviewProvider {
    static var previews: some View {
        IntroduceViewControllerRepresentable()
    }
}
