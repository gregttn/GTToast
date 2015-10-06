//
//  GTToast.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToast {
    private static let margin: CGFloat = 5.0
    private let config: GTToastConfig
    
    public init(config: GTToastConfig) {
        self.config = config
    }
    
    public func create(message: String) -> GTToastView {
        return GTToast.create(message, config: config)
    }
    
    public static func create(message: String) -> GTToastView {
        return GTToast.create(message, config: GTToastConfig())
    }
    
    public static func create(message: String, config: GTToastConfig) -> GTToastView {
        let toast = GTToastView(message: message, config: config)
        toast.frame = createFrame(toast)
        
        return toast
    }
    
    private static func createFrame(config: GTToastView) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds
        
        let size = config.sizeThatFits(CGSizeZero)
        
        let y = screenSize.height - GTToast.margin - size.height
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
    
    public init(
        contentInsets: UIEdgeInsets = GTToastConfig.defaultInsets,
        font: UIFont = GTToastConfig.defaultFont,
        textColor: UIColor = UIColor.whiteColor(),
        backgroundColor: UIColor = UIColor.blackColor(),
        displayInterval: NSTimeInterval = 4,
        animation: GTToastAnimation = .BottomSlideIn)
    {
        self.contentInsets = contentInsets
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.animation = animation
        self.displayInterval = displayInterval
    }
}

