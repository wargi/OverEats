//
//  CustomTransition.swift
//  OverEats
//
//  Created by 박소정 on 2018. 4. 17..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

final class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 애니메이션 시간
    let duration: TimeInterval = 0.5
    var isPresenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 전환 시에 관련 상위 뷰
        let containerView = transitionContext.containerView
        
        // 전환에 관련 된 지정 뷰를 리턴
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        if isPresenting {
            toView.frame.origin.y = fromView.frame.size.height
            containerView.addSubview(toView)
        } else {
            toView.frame = fromView.frame
            containerView.addSubview(toView)
            containerView.bringSubview(toFront: fromView)
        }
        
        UIView.animate(
            withDuration: duration,
            animations: {
                if self.isPresenting {
                    toView.frame.origin.y = 0
                } else {
                    fromView.frame.origin.y = -fromView.frame.size.height
                }
        },
            completion: { isFinished in
                if !self.isPresenting {
                    toView.removeFromSuperview()
                }
                transitionContext.completeTransition(isFinished)
        })
    }
    
}

