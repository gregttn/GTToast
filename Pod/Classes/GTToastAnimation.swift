//
//  GTToastAnimation.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 05/10/2015.
//
//

@available(*, deprecated, message="Use subclasses of GTAnimation directly instead.")
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
    }
}