//
//  GTToastView.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToastView: UIView, GTAnimatable {
    private var messageLabel: UILabel!
    private let config: GTToastConfig
    private let animationOffset: CGFloat = 20
    private let margin: CGFloat = 5
    private let message: String
    
    override public var frame: CGRect {
        didSet {
            guard let _ = messageLabel else {
                return
            }
            
            messageLabel.frame = CGRectMake(
                config.contentInsets.left,
                config.contentInsets.top,
                frame.size.width - config.contentInsets.right - config.contentInsets.left,
                frame.size.height - config.contentInsets.top - config.contentInsets.right
            )
        }
    }
    
    init() {
        fatalError("init() has not been implemented")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(message: String, config: GTToastConfig) {
        self.config = config
        self.message = message
        super.init(frame: CGRectZero)
        
        self.autoresizingMask = [.FlexibleTopMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
        self.backgroundColor = config.backgroundColor.colorWithAlphaComponent(0.8)
        self.layer.cornerRadius = 3.0
        
        messageLabel = createLabel()
        addSubview(messageLabel)
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.textColor = config.textColor
        label.font = config.font
        label.numberOfLines = 0
        label.text = message
        label.autoresizingMask = [.FlexibleTopMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
        
        return label
    }
    
    public override func sizeThatFits(size: CGSize) -> CGSize {
        let screenSize = UIScreen.mainScreen().bounds
        
        let maxLabelWidth = screenSize.width - 2 * margin - config.contentInsets.left - config.contentInsets.right
        let labelSize = config.font.sizeFor(message, constrain: CGSizeMake(maxLabelWidth, 0))
        let height = ceil(labelSize.height) + config.contentInsets.top + config.contentInsets.bottom
        let width = ceil(labelSize.width) + config.contentInsets.left + config.contentInsets.right
        
        return CGSizeMake(width, height)
    }
    
    public func show() {
        guard let window = UIApplication.sharedApplication().windows.first where !window.subviews.contains(self) else {
            return
        }
        
        window.addSubview(self)
        
        let (showAnimation, hideAnimation) = config.animation.animations(self)
        animateAll(self, interval: config.displayInterval, showAnimations: showAnimation, hideAnimations: hideAnimation)
    }
}

internal protocol GTAnimatable {}

internal extension GTAnimatable {
    func animateAll(view: UIView, interval: NSTimeInterval, showAnimations: () -> Void, hideAnimations: () -> Void) {
        hideAnimations()
        
        animate(0,
            animations: showAnimations,
            completion:{ _ in
                self.animate(interval,
                    animations: hideAnimations ,
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
