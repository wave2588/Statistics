//
//  StatisticsManager.swift
//  Crab-Utils
//
//  Created by wave on 2018/9/25.
//  Copyright © 2018 Zhihu. All rights reserved.
//

import Foundation
import Aspects

/*
 统计主要分为: 业务逻辑相关 and 非业务逻辑相关
 
 业务逻辑相关: 暴露出api, 供业务代码调用统计.
 非业务逻辑相关: hook 一定的方法, 进行判断统计.
 */

public class StatisticsManager {
    
    public static let shared = StatisticsManager()
    
    public var reportEventId: ((String) -> Void)?

    var hookedTokens = [AspectToken]()
}

public extension StatisticsManager {
    
    func start() {

        UIView.initializeAddGestureRecognizerMethod()
        UIButton.registerSendActionHook()
        UICollectionView.registerDidSelectedHook()
        
        UIViewController.registerViewDidLoadHook()
        
        
    }
    
    /// stop 方法暂时不完善, 请勿调用
    func stop() {
        
        hookedTokens.forEach { (token) in
            let flg = token.remove()
            if !flg{
                debugPrint("Unhook failed.")
            }
        }
        hookedTokens = [AspectToken]()
        
        UIView.unInitializeMethod()
    }
}
