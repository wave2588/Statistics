//
//  UICollectionView+Extension.swift
//  statistics
//
//  Created by wave on 2018/9/28.
//  Copyright © 2018 wave. All rights reserved.
//

import UIKit
import Aspects

private extension UICollectionView {
    
    @objc func swap(didSelectRowAtIndexPath collectionView: UICollectionView, indexPath: IndexPath) {
        swap(didSelectRowAtIndexPath: collectionView, indexPath: indexPath)
        
        if let id = collectionView.eventId {
            StatisticsManager.shared.reportEventId?(id)
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        if let id = cell?.eventId {
            StatisticsManager.shared.reportEventId?(id)
        }
    }
}

extension UICollectionView {
    
    static func registerDidSelectedHook() {
        let originalSelector = #selector(setter: UICollectionView.delegate)
        let swapSelector = #selector(swap(delegate:))
        
        guard let originalMethod = class_getInstanceMethod(self, originalSelector),
              let swapMethod = class_getInstanceMethod(self, swapSelector) else {
            return
        }
        
        method_exchangeImplementations(originalMethod, swapMethod)
    }
    
    /// 在这里拿到了 delegate
    @objc private func swap(delegate: UICollectionViewDelegate) {

        let oldSelector = #selector(delegate.collectionView(_:didSelectItemAt:))
        let swapSelector = #selector(swap(didSelectRowAtIndexPath:indexPath:))
        swapMethod(delegate: delegate, oldSelector: oldSelector, newSelector: swapSelector)
        
        swap(delegate: delegate)
    }
    
    @objc private func swapMethod(delegate: UICollectionViewDelegate, oldSelector: Selector, newSelector: Selector) {
        
        guard let delegateClass = object_getClass(delegate) else { return }
        
        if delegate.responds(to: oldSelector) {
            
            guard let methodOldDel = class_getInstanceMethod(delegateClass, oldSelector),
                  let methodNew = class_getInstanceMethod(UICollectionView.self, newSelector),
                  let oldMethodImpDel = class_getMethodImplementation(delegateClass, oldSelector),
                  let newMethodImpSelf = class_getMethodImplementation(UICollectionView.self, newSelector) else {
                return
            }
            
            /// 给代理添加 swap 方法，实现 是原来的代理方法的实现
            let isSuccess = class_addMethod(delegateClass, newSelector, oldMethodImpDel, method_getTypeEncoding(methodOldDel))
            /// 如果添加成功
            if isSuccess {
                /// 替换原来的代理方法的实现为新方法的实现
                class_replaceMethod(delegateClass, oldSelector, newMethodImpSelf, method_getTypeEncoding(methodNew))
            }
        }
    }
}
