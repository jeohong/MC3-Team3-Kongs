//
//  AuthPhoneNumberViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class AuthPhoneNumberViewController: BaseViewController {
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

struct AuthPhoneNumberViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AuthPhoneNumberViewController

    func makeUIViewController(context: Context) -> AuthPhoneNumberViewController {
        return AuthPhoneNumberViewController()
    }

    func updateUIViewController(_ uiViewController: AuthPhoneNumberViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct AuthPhoneNumberViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AuthPhoneNumberViewControllerRepresentable()
    }
}
