//
//  DancerDetailView.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/17.
//

class DancerDetailViewController: BaseViewController {
    //MARK: - Properties
    let dancerDetailScrollView: UIScrollView! = UIScrollView()
    let dancerDetailContentView: UIView! = UIView()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    //MARK: - Helpers
    func configureUI() {
        dancerDetailScrollView.translatesAutoresizingMaskIntoConstraints = false
        dancerDetailContentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dancerDetailScrollView)
        dancerDetailScrollView.addSubview(dancerDetailContentView)
        
        dancerDetailContentView.widthAnchor.constraint(equalTo: dancerDetailScrollView.widthAnchor).isActive = true

        let contentViewHeight = dancerDetailContentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        // 수직 스크롤을 적용하기 위해 contentView 와 scrollView의 width를 동일하게 잡아주고 height를 동일하게 잡아주되 priority 값을 조정하여 scroll 될 수 있도록 설정했습니다.

        NSLayoutConstraint.activate([
            dancerDetailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dancerDetailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dancerDetailScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            dancerDetailScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dancerDetailContentView.leadingAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.leadingAnchor),
            dancerDetailContentView.trailingAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.trailingAnchor),
            dancerDetailContentView.topAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.topAnchor),
            dancerDetailContentView.bottomAnchor.constraint(equalTo: dancerDetailScrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - Preview
import SwiftUI

struct DancerDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = DancerDetailViewController

    func makeUIViewController(context: Context) -> DancerDetailViewController {
        return DancerDetailViewController()
    }

    func updateUIViewController(_ uiViewController: DancerDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct DancerDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        DancerDetailViewControllerRepresentable()
    }
}
