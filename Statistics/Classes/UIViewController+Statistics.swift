//
//  UIViewController+Statistics.swift
//  Crab-Utils
//
//  Created by wave on 2018/9/25.
//  Copyright © 2018 Zhihu. All rights reserved.
//

import UIKit
import Aspects
import RxSwift
import RxCocoa
import RxViewController

public extension Reactive where Base: UIViewController {
    
    var visibleDuration: Observable<TimeInterval> {
        
        return Observable
            .zip(
                base.rx.viewWillAppear.map { _ in Date() },
                base.rx.viewWillDisappear
            )
            .map { date, _ in Date().timeIntervalSince1970 - date.timeIntervalSince1970 }
    }
}

extension UIViewController {
    
    static func registerViewDidLoadHook() {
        
        let block: @convention(block) (AnyObject) -> Void = {
            info in
            let aspectInfo = info as? AspectInfo
            guard let obj = aspectInfo?.instance() as? UIViewController else { return }
            if let id = obj.viewDidLoadEventId {
                StatisticsManager.shared.reportEventId?(id)
            }
        }
        
        let blobj: AnyObject = unsafeBitCast(block, to: AnyObject.self)
        do {
            let selector = #selector(UIViewController.viewDidLoad)
            let token = try UIViewController.aspect_hook(selector, with: AspectOptions(rawValue: 0), usingBlock: blobj)
            StatisticsManager.shared.hookedTokens.append(token)
        } catch {
            debugPrint("registerViewControllerHook hook error --->: ",error)
        }
    }
}

public extension UIViewController {
    
    private struct AssociatedKeys {
        static var viewDidLoadEventId = "viewDidLoadEventId"
    }
    

    @IBInspectable var viewDidLoadEventId: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.viewDidLoadEventId, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let id = objc_getAssociatedObject(self, &AssociatedKeys.viewDidLoadEventId) else { return nil }
            return id as? String
        }
    }
}
