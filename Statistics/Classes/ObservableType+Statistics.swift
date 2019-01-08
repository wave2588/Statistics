//
//  Observable+Statistics.swift
//  Crab-Utils
//
//  Created by wave on 2018/9/26.
//  Copyright © 2018 Zhihu. All rights reserved.
//

import UIKit
import RxSwift

public extension ObservableType where E: UIGestureRecognizer {
    
    func statistics(id: String) -> Observable<E> {
        return self.do(onNext: { $0.eventId = id })
    }
}
