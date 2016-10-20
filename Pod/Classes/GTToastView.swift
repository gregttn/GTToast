//
//  GTToastView.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

open class GTToastView: UIView, GTAnimatable {
    fileprivate let animationOffset: CGFloat = 20
    fileprivate let margin: CGFloat = 5
    
    fileprivate let config: GTToastConfig
    fileprivate let image: UIImage?
    fileprivate let message: String
    
    fileprivate var messageLabel: UILabel!
    fileprivate var imageView: UIImageView!
    
    fileprivate lazy var contentSize: CGSize = { [unowned self] in
        return CGSize(width: self.frame.size.width - self.config.contentInsets.leftAndRight, height: self.frame.size.height - self.config.contentInsets.topAndBottom)
    }()
  
    fileprivate lazy var imageSize: CGSize =  { [unowned self] in
        guard let image = self.image else {
            return CGSize.zero
        }
        
        return CGSize(
            width: min(image.size.width, self.config.maxImageSize.width),
            height: min(image.size.height, self.config.maxImageSize.height)
        )
    }()
    
    override open var frame: CGRect {
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
    
    open var displayed: Bool {
        return superview != nil
    }
    
    init() {
        fatalError("init() has not been implemented")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(message: String, config: GTToastConfig, image: UIImage? = .none) {
        self.config = config
        self.message = message
        self.image = image
        super.init(frame: CGRect.zero)
        
        self.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
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
    fileprivate func createLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = config.textAlignment
        label.textColor = config.textColor
        label.font = config.font
        label.numberOfLines = 0
        label.text = message
        label.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        return label
    }
    
    fileprivate func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        return imageView
    }
    
    fileprivate func createLabelFrame() -> CGRect {
        var x: CGFloat = config.contentInsets.left
        var y: CGFloat = config.contentInsets.top
        var width: CGFloat = contentSize.width
        var height: CGFloat = contentSize.height
        
        switch config.imageAlignment {
        case .left:
            x += imageWithMarginsSize().width
            fallthrough
        case .right:
            width -= imageWithMarginsSize().width
        case .top:
            y += config.imageMargins.topAndBottom + imageSize.height
            fallthrough
        case .bottom:
            height = height - config.imageMargins.topAndBottom - imageSize.height
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    fileprivate func createImageViewFrame() -> CGRect {
        let allInsets = config.contentInsets + config.imageMargins
        var x: CGFloat = allInsets.left
        var y: CGFloat = allInsets.top
        var width: CGFloat = imageSize.width
        var height: CGFloat = imageSize.height
        
        switch config.imageAlignment {
        case .right:
            x = frame.width - allInsets.right - imageSize.width
            fallthrough
        case .left:
            height = contentSize.height - config.imageMargins.topAndBottom
        case .bottom:
            y += calculateLabelSize().height
            fallthrough
        case .top:
            width = frame.size.width - allInsets.leftAndRight
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    // MARK: size and frame calculation
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let imageLocationAdjustment = imageLocationSizeAdjustment()
        let labelSize = calculateLabelSize()
        
        let height = labelSize.height + config.contentInsets.topAndBottom + imageLocationAdjustment.height
        let width = labelSize.width + config.contentInsets.leftAndRight + imageLocationAdjustment.width
        
        return CGSize(width: width, height: height)
    }
    
    fileprivate func calculateLabelSize() -> CGSize {
        let imageLocationAdjustment = imageLocationSizeAdjustment()
        let screenSize = UIScreen.main.bounds
        let maxLabelWidth = screenSize.width - 2 * margin - config.contentInsets.leftAndRight - imageLocationAdjustment.width
        let size = config.font.sizeFor(message, constrain: CGSize(width: maxLabelWidth, height: 0))
        
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
    fileprivate func imageLocationSizeAdjustment() -> CGSize {
        switch config.imageAlignment {
        case .left, .right:
            return CGSize(width: imageWithMarginsSize().width, height: 0)
        case .top, .bottom:
            return CGSize(width: 0, height: imageWithMarginsSize().height)
        }
    }
    
    fileprivate func imageWithMarginsSize() -> CGSize {
        guard let _ = image else {
            return CGSize.zero
        }
        
        return CGSize(
            width: imageSize.width + config.imageMargins.leftAndRight,
            height: imageSize.height + config.imageMargins.topAndBottom
        )
    }
    
    open func show() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        if !displayed {
            window.addSubview(self)
            
            animateAll(self, interval: config.displayInterval, animations: config.animation)
        }
    }
    
    open func dismiss() {
        self.config.animation.show(self)
        layer.removeAllAnimations()
        
        animate(0, animations: { self.config.animation.hide(self) }) { _ in
            self.removeFromSuperview()
        }
    }
}

internal protocol GTAnimatable {}

internal extension GTAnimatable {
    func animateAll(_ view: UIView, interval: TimeInterval, animations: GTAnimation) {
        animations.before(view)
        
        animate(0, animations: { animations.show(view) }, completion: { _ in
            
            self.animate(interval, animations: { animations.hide(view) }) { finished in
                    if finished {
                        view.removeFromSuperview()
                    }
                }
            }
        )
    }
    
    fileprivate func animate(_ interval: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.6,
            delay: interval,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: .allowUserInteraction,
            animations: animations,
            completion: completion)
    }
}
