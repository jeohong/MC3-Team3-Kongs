//
//  StudioViewController.swift
//  Hypeclass
//
//  Created by Jiyoung Park on 2022/07/30.
//

import UIKit

class StudioViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.currentUIWindow()?.safeAreaInsets.top ?? 0), left: 0, bottom: 0, right: 0)
  
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var studioHeaderView = HeaderView(frame: .zero, coverImageURL: nil, profileImageURL: nil, title: "HIGGS STUDIO", subtitle: "서울특별시 관악구 솔밭로 1 지하 1층", instagramURL: "https://instagram.com/dann.oao")
    
    private let tabCellID = "tab"
    
    private let tabString = ["소개", "클래스", "이벤트"]
    
    private let tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cv.backgroundColor = .background
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    private var selectedTab = 0
    
    private let tabIndicatorView: UIView = UIView()
    
    private var tabIndicator: Separator = {
        let sep = Separator()
        sep.backgroundColor = .white
        return sep
    }()
    
    private let sampleContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    private func configureUI() {
        // scrollView
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // contentView
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        // studioHeaderView
        contentView.addSubview(studioHeaderView)
        studioHeaderView.translatesAutoresizingMaskIntoConstraints = false
        studioHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        studioHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        studioHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        // tabCollectionView
        tabCollectionView.register(TabCell.self, forCellWithReuseIdentifier: tabCellID)
        tabCollectionView.dataSource = self
        tabCollectionView.delegate = self
        
        contentView.addSubview(tabCollectionView)
        tabCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tabCollectionView.topAnchor.constraint(equalTo: studioHeaderView.bottomAnchor).isActive = true
        tabCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tabCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tabCollectionView.heightAnchor.constraint(equalToConstant: 48).isActive = true

        // tabIndicatorView
        contentView.addSubview(tabIndicatorView)
        tabIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        tabIndicatorView.topAnchor.constraint(equalTo: tabCollectionView.bottomAnchor).isActive = true
        tabIndicatorView.leadingAnchor.constraint(equalTo: tabCollectionView.leadingAnchor).isActive = true
        tabIndicatorView.trailingAnchor.constraint(equalTo: tabCollectionView.trailingAnchor).isActive = true
        tabIndicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        // Add tabIndicator to tabIndicatorView
        tabIndicatorView.addSubview(tabIndicator)
        tabIndicator.translatesAutoresizingMaskIntoConstraints = false
        tabIndicator.topAnchor.constraint(equalTo: tabIndicatorView.topAnchor).isActive = true
        tabIndicator.leadingAnchor.constraint(equalTo: tabIndicatorView.leadingAnchor).isActive = true
        tabIndicator.bottomAnchor.constraint(equalTo: tabIndicatorView.bottomAnchor).isActive = true
        tabIndicator.widthAnchor.constraint(equalToConstant: Device.width / CGFloat(tabString.count)).isActive = true
        
//        // test
//        contentView.addSubview(sampleContentView)
//        sampleContentView.translatesAutoresizingMaskIntoConstraints = false
//        sampleContentView.topAnchor.constraint(equalTo: tabCollectionView.bottomAnchor).isActive = true
//        sampleContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        sampleContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        sampleContentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
    }
    
}

// MARK: - UICollectionView Extension

extension StudioViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCellID, for: indexPath) as! TabCell
        cell.tabNameLabel.text = tabString[indexPath.item]
        if selectedTab == indexPath.item {
            cell.tabNameLabel.textColor = .white
        } else {
            cell.tabNameLabel.textColor = .gray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tabIndicator.frame.origin.x = CGFloat(indexPath.item) * (Device.width / CGFloat(self.tabString.count))
        }
        selectedTab = indexPath.item
        collectionView.reloadData()
    }
}

extension StudioViewController: UICollectionViewDelegate {
}

extension StudioViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(tabString.count), height: collectionView.frame.height)
    }
}

//MARK: - Preview
import SwiftUI

struct StudioViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = StudioViewController

    func makeUIViewController(context: Context) -> StudioViewController {
        return StudioViewController()
    }

    func updateUIViewController(_ uiViewController: StudioViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct StudioViewControllerPreview: PreviewProvider {
    static var previews: some View {
        StudioViewControllerRepresentable()
    }
}
