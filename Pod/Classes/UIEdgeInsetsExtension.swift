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
}

func +(left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(top: left.top + right.top,
        left: left.left + right.left,
        bottom: left.bottom + right.bottom,
        right: left.right + right.right
    )
}