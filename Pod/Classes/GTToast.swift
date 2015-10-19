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
    let cornerRadius: CGFloat
    let font: UIFont
    let textColor: UIColor
    let backgroundColor: UIColor
    let displayInterval: NSTimeInterval
    let animation: GTToastAnimation
    let bottomMargin: CGFloat
    let textAlignment: NSTextAlignment
    let imageMargins: UIEdgeInsets
    let imageAlignment: GTToastAlignment
    let maxImageSize: CGSize
    
    public init(
        contentInsets: UIEdgeInsets = GTToastConfig.defaultInsets,
        cornerRadius: CGFloat = 3.0,
        font: UIFont = GTToastConfig.defaultFont,
        textColor: UIColor = UIColor.whiteColor(),
        textAlignment: NSTextAlignment = .Center,
        backgroundColor: UIColor = UIColor.blackColor().colorWithAlphaComponent(0.8),
        animation: GTToastAnimation = .BottomSlideIn,
        displayInterval: NSTimeInterval = 4,
        bottomMargin: CGFloat = 5.0,
        imageMargins: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        imageAlignment: GTToastAlignment = .Left,
        maxImageSize: CGSize = CGSizeMake(100, 200))
    {
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.animation = animation
        self.displayInterval = displayInterval
        self.bottomMargin = bottomMargin
        self.textAlignment = textAlignment
        self.imageMargins = imageMargins
        self.imageAlignment = imageAlignment
        self.maxImageSize = maxImageSize
    }
}

public enum GTToastAlignment : Int {
    case Left
    case Right
    case Top
    case Bottom

    public func defaultInsets() -> UIEdgeInsets {
        switch self {
        case .Left:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        case .Right:
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        case .Top:
            return UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        case .Bottom:
            return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        }
    }
}

