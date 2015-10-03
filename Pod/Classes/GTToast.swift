//
//  GTToast.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToast {
    private static let margin: CGFloat = 5.0
    private static let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)
    
    public static func create(message: String) -> GTToastView {
        let toast = GTToastView(frame: createFrame(message), contentInsets: GTToast.contentInsets)
        toast.messageLabel.text = message
        
        return toast
    }
    
    private static func createFrame(message: String) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds
        let width = screenSize.width - 2 * GTToast.margin
        
        let labelHeight = ceil(
                UIFont.systemFontOfSize(12.0)
                    .sizeFor(message, constrain: CGSizeMake(width - GTToast.contentInsets.left + GTToast.contentInsets.right, 0))
                    .height
        )
        
        let height = labelHeight + GTToast.contentInsets.top + GTToast.contentInsets.bottom
        let y = screenSize.height - GTToast.margin - height
        
        return CGRectMake(GTToast.margin, y, width, height)
    }
}
