//
//  GTToastView.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToastView: UIView, GTAnimatable {
    private let animationOffset: CGFloat = 20
    private let margin: CGFloat = 5
    private let maxImageSize: CGSize = CGSizeMake(100, 200)
    
    private let config: GTToastConfig
    private let image: UIImage?
    private let message: String
    
    private var messageLabel: UILabel!
    private var imageView: UIImageView!
    
    override public var frame: CGRect {
        didSet {
            guard let _ = messageLabel else {
                return
            }
            
            messageLabel.frame = labelFrame()
            
            guard let _ = image else {
                return
            }
            
            imageView.frame = imageViewFrame()
        }
    }
    
    init() {
        fatalError("init() has not been implemented")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(message: String, config: GTToastConfig, image: UIImage? = .None) {
        self.config = config
        self.message = message
        self.image = image
        super.init(frame: CGRectZero)
        
        self.autoresizingMask = [.FlexibleTopMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
        self.backgroundColor = config.backgroundColor
        self.layer.cornerRadius = 3.0
        
        messageLabel = createLabel()
        addSubview(messageLabel)
        
        if let image = image {
            imageView = createImageView()
            imageView.image = image
            addSubview(imageView)
        }
    }
    
    // MARK: creating views
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = config.textAlignment
        label.textColor = config.textColor
        label.font = config.font
        label.numberOfLines = 0
        label.text = message
        label.autoresizingMask = [.FlexibleTopMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
        
        return label
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        return imageView
    }
    
    // MARK: size and frame calculation
    public override func sizeThatFits(size: CGSize) -> CGSize {
        let imageLocationAdjustment = imageLocationSizeAdjustment()
        let labelSize = calculateLabelSize()
        
        let height = labelSize.height + config.contentInsets.topAndBottom + imageLocationAdjustment.height
        let width = labelSize.width + config.contentInsets.leftAndRight + imageLocationAdjustment.width
        
        return CGSizeMake(width, height)
    }
    
    private func calculateLabelSize() -> CGSize {
        let imageLocationAdjustment = imageLocationSizeAdjustment()
        let screenSize = UIScreen.mainScreen().bounds
        let maxLabelWidth = screenSize.width - 2 * margin - config.contentInsets.leftAndRight - imageLocationAdjustment.width
        let size = config.font.sizeFor(message, constrain: CGSizeMake(maxLabelWidth, 0))
        
        return CGSizeMake(ceil(size.width), ceil(size.height))
    }
    
    private func imageLocationSizeAdjustment() -> CGSize {
        var widthAdjustment: CGFloat = 0
        var heightAdjustment: CGFloat = 0
        
        switch config.imageAlignment {
        case .Left, .Right:
            widthAdjustment = imageWithMarginsSize().width
        case .Top, .Bottom:
            heightAdjustment = imageWithMarginsSize().height
        }
        
        return CGSizeMake(widthAdjustment, heightAdjustment)
    }
    
    private func imageViewFrame() -> CGRect {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width: CGFloat = 0
        var height: CGFloat = 0

        let allInsets = config.contentInsets + config.imageMargins
        
        switch config.imageAlignment {
        case .Left:
            x = allInsets.left
            y = allInsets.top
            width = imageSize().width
            height = contentHeight() - config.imageMargins.topAndBottom
        case .Right:
            x = frame.width - allInsets.right - imageSize().width
            y = allInsets.top
            width = imageSize().width
            height = contentHeight() - config.imageMargins.topAndBottom
        case .Top:
            x = allInsets.left
            y = allInsets.top
            width = frame.size.width - allInsets.leftAndRight
            height = imageSize().height
        case .Bottom:
            x = allInsets.left
            y = config.contentInsets.top + calculateLabelSize().height + config.imageMargins.top
            width = frame.size.width - allInsets.leftAndRight
            height = imageSize().height
        }
        
        return CGRectMake(x, y, width, height)
    }

    private func labelFrame() -> CGRect {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        switch config.imageAlignment {
        case .Left:
            x = config.contentInsets.left + imageWithMarginsSize().width
            y = config.contentInsets.top
            width = frame.size.width - config.contentInsets.leftAndRight - imageWithMarginsSize().width
            height = contentHeight()
        case .Right:
            x = config.contentInsets.left
            y = config.contentInsets.top
            width = frame.size.width - config.contentInsets.leftAndRight - imageWithMarginsSize().width
            height = contentHeight()
        case .Top:
            x = config.contentInsets.left
            y = config.contentInsets.top + config.imageMargins.topAndBottom + imageSize().height
            width = frame.size.width - config.contentInsets.leftAndRight
            height = frame.size.height - config.contentInsets.topAndBottom - config.imageMargins.topAndBottom - imageSize().height
        case .Bottom:
            x = config.contentInsets.left
            y = config.contentInsets.top
            width = frame.size.width - config.contentInsets.leftAndRight
            height = frame.size.height - config.contentInsets.topAndBottom - config.imageMargins.topAndBottom - imageSize().height
        }
        
        return CGRectMake(x, y, width, height)
    }
    
    private func imageWithMarginsSize() -> CGSize {
        guard let _ = image else {
            return CGSizeZero
        }
        
        let size = imageSize()
        
        return CGSizeMake(
            size.width + config.imageMargins.leftAndRight,
            size.height + config.imageMargins.topAndBottom
        )
    }
    
    private func imageSize() -> CGSize {
        guard let image = image else {
            return CGSizeZero
        }
        
        return CGSizeMake(
            min(image.size.width, maxImageSize.width),
            min(image.size.height, maxImageSize.height)
        )
    }
    
    private func contentHeight() -> CGFloat {
        return frame.size.height - config.contentInsets.topAndBottom
    }
    
    public func show() {
        guard let window = UIApplication.sharedApplication().windows.first where !window.subviews.contains(self) else {
            return
        }
        
        window.addSubview(self)
        
        animateAll(self, interval: config.displayInterval, animations: config.animation.animations(self))
    }
}

internal protocol GTAnimatable {}

internal extension GTAnimatable {
    func animateAll(view: UIView, interval: NSTimeInterval, animations: GTAnimations) {
        animations.before()
        
        animate(0,
            animations: animations.show,
            completion:{ _ in
                self.animate(interval,
                    animations: animations.hide ,
                    completion: { _ in view.removeFromSuperview() })
            }
        )
    }
    
    private func animate(interval: NSTimeInterval, animations: () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animateWithDuration(0.6,
            delay: interval,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: animations,
            completion: completion)
    }
}
