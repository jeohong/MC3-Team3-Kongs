//
//  ViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/11.
//

import UIKit

class MainViewController: BaseViewController {
    // MARK: - Properties
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "춤추러 가는 길, \n어려울 필요 없으니까."
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private let searchButton: UIButton = {
        var config = UIButton.Configuration.gray()
        config.baseForegroundColor = UIColor(hex: 0x7A7A7A)
        config.baseBackgroundColor = UIColor(hex: 0x2D2C38)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .large)
        config.image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)
        config.imagePadding = 13
        config.imagePlacement = .leading
        
        var titleAttr = AttributedString.init("댄서, 스튜디오 무엇이든지")
        titleAttr.font = .systemFont(ofSize: 12, weight: .regular)
        config.attributedTitle = titleAttr
        
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        button.contentHorizontalAlignment = .leading
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    // TODO: carousel View
    
    private let studioCellID = "studio"
    
    private let studioLabel: UILabel = {
        let label = UILabel()
        label.text = "함께하는 스튜디오들"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    private let studioCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .background
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        
        return cv
    }()
    
    // MARK: Should be replaced!
    
    private let genreView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private let genreTitle: UILabel = {
        let label = UILabel()
        label.text = "이 장르에 도전해보는건 어때요?"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        //MARK: - TODO: func textRect(라벨 박스 크기 확인)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let genreFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12.0
        layout.minimumInteritemSpacing = 12.0
        
        // TODO: 100, 100 frame으로 조정
        
        layout.itemSize = CGSize(width: 100, height: 100)
        return layout
      }()

    private lazy var genreCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.genreFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(MainViewControllerGenreCell.self, forCellWithReuseIdentifier: MainViewControllerGenreCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        return view
    }()
    
    private let dancerRecommendationView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dancerRecommendationTitle: UILabel = {
        let label = UILabel()
        label.text = "새로운 댄서를 반겨주세요!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dancerRecommendationFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 15.0
        layout.itemSize = CGSize(width: 155, height: 210)
        return layout
      }()
    
    private lazy var dancerRecommendationCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.dancerRecommendationFlowLayout)
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(MainViewControllerDancerCell.self, forCellWithReuseIdentifier: MainViewControllerDancerCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        return view
    }()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
    }
    
    // MARK: - Selectors
    
    @objc func searchButtonDidTap() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        
        // headerTitle
        view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 88).isActive = true
        
        // searchButton
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 30).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22).isActive = true
        
        // studioLabel
        view.addSubview(studioLabel)
        studioLabel.translatesAutoresizingMaskIntoConstraints = false
        studioLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 40).isActive = true
        studioLabel.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor).isActive = true
        
        // studioCollectionView
        studioCollectionView.register(MainStudioCell.self, forCellWithReuseIdentifier: studioCellID)
        studioCollectionView.dataSource = self
        studioCollectionView.delegate = self
        
        view.addSubview(studioCollectionView)
        studioCollectionView.translatesAutoresizingMaskIntoConstraints = false
        studioCollectionView.topAnchor.constraint(equalTo: studioLabel.bottomAnchor, constant: 8).isActive = true
        studioCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        studioCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        studioCollectionView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    private func configureCollectionView() {
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        dancerRecommendationCollectionView.dataSource = self
        dancerRecommendationCollectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, Delegate

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: count 다이내믹하게 적용
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: studioCellID, for: indexPath) as! MainStudioCell
        // TODO: url Image
        cell.studioImage = UIImageView()
        cell.studioNameLabel.text = "Studio"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: StudioViewController 이동
    }
}

extension MainViewController: UICollectionViewDelegate {
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 70)
    }
}

// MARK: - Preview

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
