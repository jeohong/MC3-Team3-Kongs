//
//  DanceClassDetailViewController.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/07/30.
//

import UIKit

class DanceClassDetailViewController: BaseViewController {
    
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

struct DanceClassDetailViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = DanceClassDetailViewController

    func makeUIViewController(context: Context) -> DanceClassDetailViewController {
        return DanceClassDetailViewController()
    }

    func updateUIViewController(_ uiViewController: DanceClassDetailViewController, context: Context) {}
}

@available(iOS 13.0.0, *)
struct DanceClassDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        DanceClassDetailViewControllerRepresentable()
    }
}
