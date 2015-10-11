//
//  GTToast.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToast {
    private let config: GTToastConfig
    
    public init(config: GTToastConfig) {
        self.config = config
    }
    
    public func create(message: String, image: UIImage? = .None) -> GTToastView {
        return GTToast.create(message, config: config, image: image)
    }
    
    public static func create(message: String, config: GTToastConfig = GTToastConfig(), image: UIImage? = .None) -> GTToastView {
        let toast = GTToastView(message: message, config: config, image: image)
        toast.frame = createFrame(toast, config: config)
        
        return toast
    }
    
    private static func createFrame(view: GTToastView, config: GTToastConfig) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds
        
        let size = view.sizeThatFits(CGSizeZero)
        
        let y = screenSize.height - config.bottomMargin - size.height
        let x = ceil((screenSize.width - size.width) / 2.0)
        
        return CGRectMake(x, y, size.width, size.height)
    }
}

public struct GTToastConfig {
    static let defaultInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)
    static let defaultFont = UIFont.systemFontOfSize(12.0)
    
    let contentInsets: UIEdgeInsets
    let font: UIFont
    let textColor: UIColor
    let backgroundColor: UIColor
    let displayInterval: NSTimeInterval
    let animation: GTToastAnimation
    let bottomMargin: CGFloat
    let textAlignment: NSTextAlignment
    let imageMargins: UIEdgeInsets
    
    public init(
        contentInsets: UIEdgeInsets = GTToastConfig.defaultInsets,
        font: UIFont = GTToastConfig.defaultFont,
        textColor: UIColor = UIColor.whiteColor(),
        textAlignment: NSTextAlignment = .Center,
        backgroundColor: UIColor = UIColor.blackColor(),
        animation: GTToastAnimation = .BottomSlideIn,
        displayInterval: NSTimeInterval = 4,
        bottomMargin: CGFloat = 5.0,
        imageMargins: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5))
    {
        self.contentInsets = contentInsets
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.animation = animation
        self.displayInterval = displayInterval
        self.bottomMargin = bottomMargin
        self.textAlignment = textAlignment
        self.imageMargins = imageMargins
    }
}

