//
//  UICollectionView+RXStatistics.swift
//  Statistics
//
//  Created by wave on 2019/1/8.
//  Copyright © 2019 wave. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ControlEvent where PropertyType == IndexPath {
    
    /// 多种统计类型, 有多少种类型就传入多少个id, 其中若有一个没有id则传入 "", 不能不传.
    func statistics(ids: [String]) -> Observable<IndexPath> {
        return self.do(onNext: { ip in
            debugPrint(ids.count, ip.row)
            if ids.count < ip.row + 1 {
                assert(false, "ids != ip.row")
                return
            }
            let id = ids[ip.row]
            StatisticsManager.shared.reportEventId?(id)
        })
    }
    
    /// 一种统计类型
    func statistics(id: String) -> Observable<IndexPath> {
        return self.do(onNext: { _ in
            StatisticsManager.shared.reportEventId?(id)
        })
    }
}
