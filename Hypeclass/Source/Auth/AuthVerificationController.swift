//
//  AuthVerificationController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class AuthVerificationController: BaseViewController {
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

struct AuthVerificationControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AuthVerificationController

    func makeUIViewController(context: Context) -> AuthVerificationController {
        return AuthVerificationController()
    }

    func updateUIViewController(_ uiViewController: AuthVerificationController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct AuthVerificationControllerPreview: PreviewProvider {
    static var previews: some View {
        AuthVerificationControllerRepresentable()
    }
}
