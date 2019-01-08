//
//  UIView+Statistics.swift
//  Crab-Utils
//
//  Created by wave on 2018/9/25.
//  Copyright © 2018 Zhihu. All rights reserved.
//

import UIKit

/// 这里主要是为了重写手势部分的...
extension UIView {
    
    static func unInitializeMethod() {
        /// comming soon...
    }
    
    static func initializeAddGestureRecognizerMethod() {
        let originalSelector = #selector(addGestureRecognizer(_:))
        let swopSelector = #selector(swopAddGestureRecognizer(gesture:))
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swopMethos = class_getInstanceMethod(self, swopSelector)
        method_exchangeImplementations(originalMethod!, swopMethos!)
    }
    
    @objc private func swopAddGestureRecognizer(gesture: UIGestureRecognizer) {
        swopAddGestureRecognizer(gesture: gesture)
        gesture.addTarget(self, action: #selector(gestureStatisticsAction(gesture:)))
    }
    
    @objc private func gestureStatisticsAction(gesture: UIGestureRecognizer) {
        if let id = gesture.eventId {
            if gesture.state == .ended {
                StatisticsManager.shared.reportEventId?(id)
            }
        }
    }
}

