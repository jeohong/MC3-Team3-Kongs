//
//  AuthViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class AuthViewController: BaseViewController, UITextFieldDelegate {
    //MARK: - Properties
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.text = "신청자의 이름을 알려주세요."
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let nameContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .container
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름"
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.textColor = .white
        textField.tintColor = .label
        textField.frame.size = CGSize(width: 300, height: 50)
        textField.addDoneButtonOnKeyboard()
        return textField
    }()
    
    private let phoneNumberContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .container
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let phoneNumberField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호"
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.textColor = .white
        textField.tintColor = .label
        textField.frame.size = CGSize(width: 300, height: 50)
        return textField
    }()
    
    private let inputInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "반드시 본명을 입력해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let ctaButton: CTAButton = {
        let button = CTAButton(title: "다음")
        button.addTarget(self, action: #selector(ctaButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        dismissKeyboardWhenTappedAround()
        nameTextField.delegate = self
        phoneNumberField.delegate = self
    }
    
    //MARK: - Selectors
    
    @objc func ctaButtonTap() {
        print("DEBUG: CTAButton Tapp")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        //레이아웃 구성
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(primaryLabel)
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primaryLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60),
            primaryLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25)
        ])
        
        view.addSubview(inputInfoLabel)
        inputInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputInfoLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 30),
            inputInfoLabel.leadingAnchor.constraint(equalTo: primaryLabel.leadingAnchor)
        ])
        
        view.addSubview(nameContainer)
        nameContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameContainer.topAnchor.constraint(equalTo: inputInfoLabel.bottomAnchor, constant: 10),
            nameContainer.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameContainer.heightAnchor.constraint(equalToConstant: 50),
            nameContainer.leadingAnchor.constraint(equalTo: inputInfoLabel.leadingAnchor),
            nameContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25)
        ])
        
        nameContainer.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 20),
            nameTextField.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(phoneNumberContainer)
        phoneNumberContainer.translatesAutoresizingMaskIntoConstraints = false
  
        
        view.addSubview(ctaButton)
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            ctaButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            ctaButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
