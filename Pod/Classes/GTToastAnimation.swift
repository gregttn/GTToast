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
    
    public func animations(view: UIView) -> GTAnimations {
        let screenSize = UIScreen.mainScreen().bounds
        var showAnimations = {}
        var hideAnimations = {}
        var before = {}
        
        switch self{
        case .Alpha:
            before = { view.alpha = 0 }
            showAnimations = { view.alpha = 1 }
            hideAnimations = before
        case .BottomSlideIn:
            before = { view.transform = CGAffineTransformMakeTranslation(0, screenSize.height - view.frame.origin.y)}
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = before
        case .LeftSlideIn :
            before = { view.transform = CGAffineTransformMakeTranslation(-view.frame.origin.x-view.frame.width, 0)}
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = before
        case .RightSlideIn :
            before = { view.transform = CGAffineTransformMakeTranslation(screenSize.width - view.frame.origin.x, 0)}
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = before
        case .Scale :
            before = { view.transform = CGAffineTransformMakeScale(0.00000001, 0.00000001)}
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = before
        case .LeftInRightOut:
            before = { view.transform = CGAffineTransformMakeTranslation(-view.frame.origin.x-view.frame.width, 0)}
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(screenSize.width - view.frame.origin.x, 0)}
        case .RightInLeftOut:
            before = { view.transform = CGAffineTransformMakeTranslation(screenSize.width - view.frame.origin.x, 0)}
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(-view.frame.origin.x-view.frame.width, 0)}
            break
        }
        
        return GTAnimations(before: before, show: showAnimations, hide: hideAnimations)
    }
}

public struct GTAnimations {
    public let before: () -> Void
    public let show: () -> Void
    public let hide: () -> Void
}