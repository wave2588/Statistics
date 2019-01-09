//
//  EventID.swift
//  Statistics
//
//  Created by wave on 2019/1/8.
//  Copyright © 2019 wave. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer {
    
    private struct AssociatedKeys {
        static var eventId = "eventId"
    }
    
    @IBInspectable var eventId: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventId, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let id = objc_getAssociatedObject(self, &AssociatedKeys.eventId) else { return nil }
            return id as? String
        }
    }
}

public extension UIView {
    
    private struct AssociatedKeys {
        static var eventId = "eventId"
    }
    
    @IBInspectable var eventId: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventId, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let id = objc_getAssociatedObject(self, &AssociatedKeys.eventId) else { return nil }
            return id as? String
        }
    }
}

extension UIViewController {
    
    private struct AssociatedKeys {
        static var viewDidLoadEventId = "viewDidLoadEventId"
    }
    
    @IBInspectable open var viewDidLoadEventId: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.viewDidLoadEventId, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let id = objc_getAssociatedObject(self, &AssociatedKeys.viewDidLoadEventId) else { return nil }
            return id as? String
        }
    }
}
