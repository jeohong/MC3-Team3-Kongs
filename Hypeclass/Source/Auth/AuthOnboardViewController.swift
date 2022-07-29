//
//  AuthOnboardViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class AuthOnboardViewController: BaseViewController {
    

    //MARK: - Properties
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.text = "댄서들의 클래스 수강신청\n디라이트에서 간편하게"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "한번 회원가입하고,\n버튼하나로 간단하게 수업을 신청하세요."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    //MARK: - Helpers
    func configureUI() {
        //레이아웃 구성
        view.addSubview(primaryLabel)
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            primaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        ])
        
        view.addSubview(secondaryLabel)
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondaryLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 20),
            secondaryLabel.leadingAnchor.constraint(equalTo: primaryLabel.leadingAnchor)
        ])
    }
}

//MARK: - Preview
import SwiftUI

struct AuthOnboardViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AuthOnboardViewController

    func makeUIViewController(context: Context) -> AuthOnboardViewController {
        return AuthOnboardViewController()
    }

    func updateUIViewController(_ uiViewController: AuthOnboardViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct AuthOnboardViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AuthOnboardViewControllerRepresentable()
    }
}
