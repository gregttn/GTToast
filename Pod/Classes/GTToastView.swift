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
    
    private let config: GTToastConfig
    private let image: UIImage?
    private let message: String
    
    private var messageLabel: UILabel!
    private var imageView: UIImageView!
    
    private lazy var contentSize: CGSize = { [unowned self] in
        return CGSizeMake(self.frame.size.width - self.config.contentInsets.leftAndRight, self.frame.size.height - self.config.contentInsets.topAndBottom)
    }()
  
    private lazy var imageSize: CGSize =  { [unowned self] in
        guard let image = self.image else {
            return CGSizeZero
        }
        
        return CGSizeMake(
            min(image.size.width, self.config.maxImageSize.width),
            min(image.size.height, self.config.maxImageSize.height)
        )
    }()
    
    override public var frame: CGRect {
        didSet {
            guard let _ = messageLabel else {
                return
            }
            
            messageLabel.frame = createLabelFrame()
            
            guard let _ = image else {
                return
            }
            
            imageView.frame = createImageViewFrame()
        }
    }
    
    public var displayed: Bool {
        return superview != nil
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
        self.layer.cornerRadius = config.cornerRadius
        
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
    
    private func createLabelFrame() -> CGRect {
        var x: CGFloat = config.contentInsets.left
        var y: CGFloat = config.contentInsets.top
        var width: CGFloat = contentSize.width
        var height: CGFloat = contentSize.height
        
        switch config.imageAlignment {
        case .Left:
            x += imageWithMarginsSize().width
            fallthrough
        case .Right:
            width -= imageWithMarginsSize().width
        case .Top:
            y += config.imageMargins.topAndBottom + imageSize.height
            fallthrough
        case .Bottom:
            height = height - config.imageMargins.topAndBottom - imageSize.height
        }
        
        return CGRectMake(x, y, width, height)
    }
    
    private func createImageViewFrame() -> CGRect {
        let allInsets = config.contentInsets + config.imageMargins
        var x: CGFloat = allInsets.left
        var y: CGFloat = allInsets.top
        var width: CGFloat = imageSize.width
        var height: CGFloat = imageSize.height
        
        switch config.imageAlignment {
        case .Right:
            x = frame.width - allInsets.right - imageSize.width
            fallthrough
        case .Left:
            height = contentSize.height - config.imageMargins.topAndBottom
        case .Bottom:
            y += calculateLabelSize().height
            fallthrough
        case .Top:
            width = frame.size.width - allInsets.leftAndRight
        }
        
        return CGRectMake(x, y, width, height)
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
        switch config.imageAlignment {
        case .Left, .Right:
            return CGSizeMake(imageWithMarginsSize().width, 0)
        case .Top, .Bottom:
            return CGSizeMake(0, imageWithMarginsSize().height)
        }
    }
    
    private func imageWithMarginsSize() -> CGSize {
        guard let _ = image else {
            return CGSizeZero
        }
        
        return CGSizeMake(
            imageSize.width + config.imageMargins.leftAndRight,
            imageSize.height + config.imageMargins.topAndBottom
        )
    }
    
    public func show() {
        guard let window = UIApplication.sharedApplication().windows.first else {
            return
        }
        
        if !displayed {
            window.addSubview(self)
            
            animateAll(self, interval: config.displayInterval, animations: config.animation.animations(self))
        }
    }
    
    public func dismiss() {
        self.config.animation.animations(self).show()
        layer.removeAllAnimations()
        
        animate(0, animations: config.animation.animations(self).hide) { _ in
            self.removeFromSuperview()
        }
    }
}

internal protocol GTAnimatable {}

internal extension GTAnimatable {
    func animateAll(view: UIView, interval: NSTimeInterval, animations: GTAnimations) {
        animations.before()
        
        animate(0, animations: animations.show, completion: { _ in
            
                self.animate(interval, animations: animations.hide) { finished in
                    if finished {
                        view.removeFromSuperview()
                    }
                }
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
