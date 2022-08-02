//
//  EventManager.swift
//  Hypeclass
//
//  Created by GOngTAE on 2022/08/02.
//

import UIKit

class EventManager: BaseViewController {
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

struct EventManagerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = EventManager

    func makeUIViewController(context: Context) -> EventManager {
        return EventManager()
    }

    func updateUIViewController(_ uiViewController: EventManager, context: Context) {}
}

@available(iOS 13.0.0, *)
struct EventManagerPreview: PreviewProvider {
    static var previews: some View {
        EventManagerRepresentable()
    }
}
