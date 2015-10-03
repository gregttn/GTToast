//
//  UIFontExtensions.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

extension UIFont {
    func sizeFor(content: String, constrain: CGSize) -> CGSize {
        return NSString(string: content).boundingRectWithSize(
            constrain,
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName : self],
            context: nil)
        .size
    }
}
