//
//  UIApplication.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import Foundation
import UIKit

extension UIApplication {    
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}
