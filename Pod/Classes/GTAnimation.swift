//
//  GTAnimation.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 14/08/2016.
//
//

import Foundation

public protocol GTAnimation {
    func before(_ view: UIView) -> Void
    func show(_ view: UIView) -> Void
    func hide(_ view: UIView) -> Void
}

open class GTNoAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
    }
    
    open func show(_ view: UIView) -> Void {
    }
    
    open func hide(_ view: UIView) -> Void {
    }
}

open class GTAlphaAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
        view.alpha = 0
    }
    
    open func show(_ view: UIView) -> Void {
        view.alpha = 1
    }
    
    open func hide(_ view: UIView) -> Void {
        before(view)
    }
}

open class GTBottomSlideInAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
        let screenSize = UIScreen.main.bounds
        
        view.transform = CGAffineTransform(translationX: 0, y: screenSize.height - view.frame.origin.y)
    }
    
    open func show(_ view: UIView) -> Void {
        view.transform = CGAffineTransform.identity
    }
    
    open func hide(_ view: UIView) -> Void {
        before(view)
    }
}

open class GTLeftSlideInAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
        view.transform = CGAffineTransform(translationX: -view.frame.origin.x-view.frame.width, y: 0)
    }
    
    open func show(_ view: UIView) -> Void {
        view.transform = CGAffineTransform.identity
    }
    
    open func hide(_ view: UIView) -> Void {
        before(view)
    }
}

open class GTRightSlideInAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
        let screenSize = UIScreen.main.bounds
        
        view.transform = CGAffineTransform(translationX: screenSize.width - view.frame.origin.x, y: 0)
    }
    
    open func show(_ view: UIView) -> Void {
        view.transform = CGAffineTransform.identity
    }
    
    open func hide(_ view: UIView) -> Void {
        before(view)
    }
}

open class GTScaleAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
        view.transform = CGAffineTransform(scaleX: 0.00000001, y: 0.00000001)
    }
    
    open func show(_ view: UIView) -> Void {
        view.transform = CGAffineTransform.identity
    }
    
    open func hide(_ view: UIView) -> Void {
        before(view)
    }
}

open class GTLeftInRightOutAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
        view.transform = CGAffineTransform(translationX: -view.frame.origin.x-view.frame.width, y: 0)
    }
    
    open func show(_ view: UIView) -> Void {
        view.transform = CGAffineTransform.identity
    }
    
    open func hide(_ view: UIView) -> Void {
        let screenSize = UIScreen.main.bounds
        view.transform = CGAffineTransform(translationX: screenSize.width - view.frame.origin.x, y: 0)
    }
}

open class GTRightInLeftOutAnimation: GTAnimation {
    public init() {}
    
    open func before(_ view: UIView) -> Void {
        let screenSize = UIScreen.main.bounds
        view.transform = CGAffineTransform(translationX: screenSize.width - view.frame.origin.x, y: 0)
    }
    
    open func show(_ view: UIView) -> Void {
        view.transform = CGAffineTransform.identity
    }
    
    open func hide(_ view: UIView) -> Void {
        view.transform = CGAffineTransform(translationX: -view.frame.origin.x-view.frame.width, y: 0)
    }
}
