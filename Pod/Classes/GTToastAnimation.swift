//
//  GTToastAnimation.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 05/10/2015.
//
//
public enum GTToastAnimation: Int {
    case Alpha
    case Scale
    case BottomSlideIn
    case LeftSlideIn
    case RightSlideIn
    case LeftInRightOut
    case RightInLeftOut
    
    public func animations() -> GTAnimations {
        switch self{
        case .Alpha:
            return GTAlphaAnimations()
        case .BottomSlideIn:
            return GTBottomSlideInAnimations()
        case .LeftSlideIn :
            return GTLeftSlideInAnimations()
        case .RightSlideIn :
            return GTRightSlideInAnimations()
        case .Scale :
            return GTScaleAnimations()
        case .LeftInRightOut:
            return GTLeftInRightOutAnimations()
        case .RightInLeftOut:
            return GTRightInLeftOutAnimation()
        }
        
        return GTNoAnimations()
    }
}

public protocol GTAnimations {
    func before(view: UIView) -> Void
    func show(view: UIView) -> Void
    func hide(view: UIView) -> Void
}

public class GTNoAnimations: GTAnimations{
    public func before(view: UIView) -> Void {
    }
    
    public func show(view: UIView) -> Void {
    }
    
    public func hide(view: UIView) -> Void {
    }
}

public class GTAlphaAnimations: GTAnimations{
    public func before(view: UIView) -> Void {
        view.alpha = 0
    }
    
    public func show(view: UIView) -> Void {
        view.alpha = 1
    }
    
    public func hide(view: UIView) -> Void {
        before(view)
    }
}

public class GTBottomSlideInAnimations: GTAnimations {
    public func before(view: UIView) -> Void {
        let screenSize = UIScreen.mainScreen().bounds
        
        view.transform = CGAffineTransformMakeTranslation(0, screenSize.height - view.frame.origin.y)
    }
    
    public func show(view: UIView) -> Void {
        view.transform = CGAffineTransformIdentity
    }
    
    public func hide(view: UIView) -> Void {
        before(view)
    }
}

public class GTLeftSlideInAnimations: GTAnimations {
    public func before(view: UIView) -> Void {
        let screenSize = UIScreen.mainScreen().bounds
        
        view.transform = CGAffineTransformMakeTranslation(-view.frame.origin.x-view.frame.width, 0)
    }
    
    public func show(view: UIView) -> Void {
        view.transform = CGAffineTransformIdentity
    }
    
    public func hide(view: UIView) -> Void {
        before(view)
    }
}

public class GTRightSlideInAnimations: GTAnimations {
    public func before(view: UIView) -> Void {
        let screenSize = UIScreen.mainScreen().bounds
        
        view.transform = CGAffineTransformMakeTranslation(screenSize.width - view.frame.origin.x, 0)
    }
    
    public func show(view: UIView) -> Void {
        view.transform = CGAffineTransformIdentity
    }
    
    public func hide(view: UIView) -> Void {
        before(view)
    }
}

public class GTScaleAnimations: GTAnimations {
    public func before(view: UIView) -> Void {
        view.transform = CGAffineTransformMakeScale(0.00000001, 0.00000001)
    }
    
    public func show(view: UIView) -> Void {
        view.transform = CGAffineTransformIdentity
    }
    
    public func hide(view: UIView) -> Void {
        before(view)
    }
}

public class GTLeftInRightOutAnimations: GTAnimations {
    public func before(view: UIView) -> Void {
        view.transform = CGAffineTransformMakeTranslation(-view.frame.origin.x-view.frame.width, 0)
    }
    
    public func show(view: UIView) -> Void {
        view.transform = CGAffineTransformIdentity
    }
    
    public func hide(view: UIView) -> Void {
        let screenSize = UIScreen.mainScreen().bounds
        view.transform = CGAffineTransformMakeTranslation(screenSize.width - view.frame.origin.x, 0)
    }
}

public class GTRightInLeftOutAnimation: GTAnimations {
    public func before(view: UIView) -> Void {
        let screenSize = UIScreen.mainScreen().bounds
        view.transform = CGAffineTransformMakeTranslation(screenSize.width - view.frame.origin.x, 0)
    }
    
    public func show(view: UIView) -> Void {
        view.transform = CGAffineTransformIdentity
    }
    
    public func hide(view: UIView) -> Void {
        view.transform = CGAffineTransformMakeTranslation(-view.frame.origin.x-view.frame.width, 0)
    }
}