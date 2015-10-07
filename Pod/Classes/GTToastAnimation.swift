//
//  GTToastAnimation.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 05/10/2015.
//
//
public enum GTToastAnimation: Int {
    case Alpha
    case BottomSlideIn
    case LeftSlideIn
    case RightSlideIn
    case Scale
    
    public func animations(view: UIView) -> GTAnimations {
        let screenSize = UIScreen.mainScreen().bounds
        var showAnimations = {}
        var hideAnimations = {}
        
        switch self{
        case .Alpha:
            showAnimations = { view.alpha = 1 }
            hideAnimations = { view.alpha = 0 }
        case .BottomSlideIn:
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(0, screenSize.height - view.frame.origin.y)}
        case .LeftSlideIn :
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(-view.frame.origin.x-view.frame.width, 0)}
        case .RightSlideIn :
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(screenSize.width - view.frame.origin.x, 0)}
        case .Scale :
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeScale(0.00000001, 0.00000001)}
        }
        
        return GTAnimations(before: hideAnimations, show: showAnimations, hide: hideAnimations)
    }
}

public struct GTAnimations {
    public let before: () -> Void
    public let show: () -> Void
    public let hide: () -> Void
}