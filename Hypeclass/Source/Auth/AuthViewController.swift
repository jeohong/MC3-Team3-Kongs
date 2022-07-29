//
//  AuthViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class AuthViewController: BaseViewController {
    //MARK: - Properties
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    //MARK: - Helpers
    func configureUI() {
        //레이아웃 구성
    }
}

//MARK: - Preview
import SwiftUI

struct AuthViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AuthViewController

    func makeUIViewController(context: Context) -> AuthViewController {
        return AuthViewController()
    }

    func updateUIViewController(_ uiViewController: AuthViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct AuthViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AuthViewControllerRepresentable()
    }
}
