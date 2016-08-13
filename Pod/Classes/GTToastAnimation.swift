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
    
    public func animations() -> GTAnimation {
        switch self{
        case .Alpha:
            return GTAlphaAnimation()
        case .BottomSlideIn:
            return GTBottomSlideInAnimation()
        case .LeftSlideIn :
            return GTLeftSlideInAnimation()
        case .RightSlideIn :
            return GTRightSlideInAnimation()
        case .Scale :
            return GTScaleAnimation()
        case .LeftInRightOut:
            return GTLeftInRightOutAnimation()
        case .RightInLeftOut:
            return GTRightInLeftOutAnimation()
        }
        
        return GTNoAnimation()
    }
}

public protocol GTAnimation {
    func before(view: UIView) -> Void
    func show(view: UIView) -> Void
    func hide(view: UIView) -> Void
}

public class GTNoAnimation: GTAnimation {
    public func before(view: UIView) -> Void {
    }
    
    public func show(view: UIView) -> Void {
    }
    
    public func hide(view: UIView) -> Void {
    }
}

public class GTAlphaAnimation: GTAnimation {
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

public class GTBottomSlideInAnimation: GTAnimation {
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

public class GTLeftSlideInAnimation: GTAnimation {
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

public class GTRightSlideInAnimation: GTAnimation {
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

public class GTScaleAnimation: GTAnimation {
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

public class GTLeftInRightOutAnimation: GTAnimation {
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

public class GTRightInLeftOutAnimation: GTAnimation {
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