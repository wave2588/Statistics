//
//  UIScrollView+Statistics.swift
//  Crab-Utils
//
//  Created by wave on 2018/9/27.
//  Copyright © 2018 Zhihu. All rights reserved.
//

import UIKit
import Aspects
import RxSwift

public extension Reactive where Base: UIScrollView {
    
    var scrollDown: Observable<Void> {
        return Observable
            .zip(
                base.rx.willBeginDragging.map { [unowned base] in base.contentOffset.y },
                base.rx.didEndDragging.map { [unowned base] _ in base.contentOffset.y }
            )
            .filter { begin, end in end > begin }
            .mapVoid()
    }
}

public extension ObservableType {
    
    func mapVoid() -> Observable<Void> {
        return map { _ -> Void in }
    }
    
}


