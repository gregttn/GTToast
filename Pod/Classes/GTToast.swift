//
//  GTToast.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToast {
    internal static let padding: CGFloat = 5.0
    internal static let defaultHeight: CGFloat = 60.0
    
    public static func create(message: String) -> GTToastView {
        return GTToastView(frame: createFrame())
    }
    
    private static func createFrame() -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds
        let y = screenSize.height - GTToast.padding - GTToast.defaultHeight
        let width = screenSize.width - 2 * GTToast.padding
        
        return CGRectMake(GTToast.padding, y, width, GTToast.defaultHeight)
    }
}
