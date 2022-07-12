//
//  SubscriptionViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/12.
//

import UIKit

class SubscriptionViewController: BaseViewController {
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

struct SubscriptionViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SubscriptionViewController

    func makeUIViewController(context: Context) -> SubscriptionViewController {
        return SubscriptionViewController()
    }

    func updateUIViewController(_ uiViewController: SubscriptionViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct SubscriptionViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SubscriptionViewControllerRepresentable()
    }
}
