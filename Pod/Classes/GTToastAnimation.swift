//
//  GTToastAnimation.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 05/10/2015.
//
//

@available(*, deprecated, message: "Use subclasses of GTAnimation directly instead.")
public enum GTToastAnimation: Int {
    case alpha
    case scale
    case bottomSlideIn
    case leftSlideIn
    case rightSlideIn
    case leftInRightOut
    case rightInLeftOut
    
    public func animations() -> GTAnimation {
        switch self{
        case .alpha:
            return GTAlphaAnimation()
        case .bottomSlideIn:
            return GTBottomSlideInAnimation()
        case .leftSlideIn :
            return GTLeftSlideInAnimation()
        case .rightSlideIn :
            return GTRightSlideInAnimation()
        case .scale :
            return GTScaleAnimation()
        case .leftInRightOut:
            return GTLeftInRightOutAnimation()
        case .rightInLeftOut:
            return GTRightInLeftOutAnimation()
        }
    }
}
