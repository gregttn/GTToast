//
//  UIEdgeInsetsExtension.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 12/10/2015.
//
//

internal extension UIEdgeInsets {
    var leftAndRight: CGFloat {
        get {
            return left + right
        }
    }
    
    var topAndBottom: CGFloat {
        get {
            return top + bottom
        }
    }
    
    func sum(insets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: top + insets.top,
            left: left + insets.left,
            bottom: bottom + insets.bottom,
            right: right + insets.right
        )
    }
}