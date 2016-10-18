//
//  UIFontExtensions.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

extension UIFont {
    func sizeFor(_ content: String, constrain: CGSize) -> CGSize {
        return NSString(string: content).boundingRect(
            with: constrain,
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSFontAttributeName : self],
            context: nil)
        .size
    }
}
