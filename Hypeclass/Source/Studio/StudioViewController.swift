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
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var studioHeaderView = HeaderView(frame: .zero, coverImageURL: nil, profileImageURL: nil, title: "HIGGS STUDIO", subtitle: "서울특별시 관악구 솔밭로 1 지하 1층", instagramURL: "https://instagram.com/dann.oao")
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.scrollView.contentInsetAdjustmentBehavior = .never;
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
