//
//  UIButton+Statistics.swift
//  Crab-Utils
//
//  Created by wave on 2018/9/25.
//  Copyright © 2018 Zhihu. All rights reserved.
//

import UIKit
import Aspects

extension UIButton {
    
    static func registerSendActionHook() {
        
        let block: @convention(block) (AnyObject) -> Void = {
            info in
            let aspectInfo = info as? AspectInfo
            guard let obj = aspectInfo?.instance() as? UIButton else { return }
            if let id = obj.eventId {
                StatisticsManager.shared.reportEventId?(id)
            }
        }
        
        let blobj: AnyObject = unsafeBitCast(block, to: AnyObject.self)
        do {
            let selector = #selector(UIButton.sendAction(_:to:for:))
            let token = try UIButton.aspect_hook(selector, with: .positionBefore, usingBlock: blobj)
            StatisticsManager.shared.hookedTokens.append(token)
        } catch {
            debugPrint("registerBtnSendActionHook hook error --->: ",error)
        }
    }
}

