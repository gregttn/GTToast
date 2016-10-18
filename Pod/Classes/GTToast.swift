//
//  GTToast.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

open class GTToast {
    fileprivate let config: GTToastConfig
    
    public init(config: GTToastConfig) {
        self.config = config
    }
    
    open func create(_ message: String, image: UIImage? = .none) -> GTToastView {
        return GTToast.create(message, config: config, image: image)
    }
    
    open static func create(_ message: String, config: GTToastConfig = GTToastConfig(), image: UIImage? = .none) -> GTToastView {
        let toast = GTToastView(message: message, config: config, image: image)
        toast.frame = createFrame(toast, config: config)
        
        return toast
    }
    
    fileprivate static func createFrame(_ view: GTToastView, config: GTToastConfig) -> CGRect {
        let screenSize = UIScreen.main.bounds
        
        let size = view.sizeThatFits(CGSize.zero)
        
        let y = screenSize.height - config.bottomMargin - size.height
        let x = ceil((screenSize.width - size.width) / 2.0)
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

public struct GTToastConfig {
    static let defaultInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)
    static let defaultFont = UIFont.systemFont(ofSize: 12.0)
    
    let contentInsets: UIEdgeInsets
    let cornerRadius: CGFloat
    let font: UIFont
    let textColor: UIColor
    let backgroundColor: UIColor
    let displayInterval: TimeInterval
    let animation: GTAnimation
    let bottomMargin: CGFloat
    let textAlignment: NSTextAlignment
    let imageMargins: UIEdgeInsets
    let imageAlignment: GTToastAlignment
    let maxImageSize: CGSize
    
    public init(
        contentInsets: UIEdgeInsets = GTToastConfig.defaultInsets,
        cornerRadius: CGFloat = 3.0,
        font: UIFont = GTToastConfig.defaultFont,
        textColor: UIColor = UIColor.white,
        textAlignment: NSTextAlignment = .center,
        backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.8),
        animation: GTAnimation = GTBottomSlideInAnimation(),
        displayInterval: TimeInterval = 4,
        bottomMargin: CGFloat = 5.0,
        imageMargins: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        imageAlignment: GTToastAlignment = .left,
        maxImageSize: CGSize = CGSize(width: 100, height: 200))
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
    case left
    case right
    case top
    case bottom

    public func defaultInsets() -> UIEdgeInsets {
        switch self {
        case .left:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        case .right:
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        case .top:
            return UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        case .bottom:
            return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        }
    }
}

