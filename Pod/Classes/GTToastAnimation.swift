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
    
    internal func animations(view: UIView) -> (() -> Void, () -> Void) {
        var showAnimations = {}
        var hideAnimations = {}
        
        switch self{
        case .Alpha:
            showAnimations = { view.alpha = 1 }
            hideAnimations = { view.alpha = 0 }
        case .BottomSlideIn:
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(0, view.frame.height + 20)}
        case .LeftSlideIn :
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(-view.frame.width - 20, 0)}
        case .RightSlideIn :
            showAnimations = { view.transform = CGAffineTransformIdentity }
            hideAnimations = { view.transform = CGAffineTransformMakeTranslation(view.frame.width + 20, 0)}
        }
        
        return (showAnimations, hideAnimations)
    }
}