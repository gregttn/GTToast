//
//  GTToastView.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToastView: UIView {
    private var messageLabel: UILabel!
    private let config: GTToastConfig
    private let displayInterval: NSTimeInterval = 4
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
        let firstWindow = UIApplication.sharedApplication().windows.first
        
        guard let window = firstWindow where !window.subviews.contains(self) else {
            return
        }
        
        window.addSubview(self)
        
        transform = CGAffineTransformMakeTranslation(0, frame.height + animationOffset)
        
        animate(0,
            animations: { self.transform = CGAffineTransformIdentity },
            completion: { (finished) in
                self.remove(self.displayInterval)
            }
        )
    }
    
    private func remove(delay: NSTimeInterval) {
        animate(delay,
            animations: { self.transform = CGAffineTransformMakeTranslation(0, self.frame.height + self.animationOffset) },
            completion: { (finished) in
                self.removeFromSuperview()
            }
        )
    }
    
    private func animate(delay: NSTimeInterval, animations: () -> Void, completion: (finished: Bool) -> Void) {
        UIView.animateWithDuration(0.6,
            delay: delay,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            options: [.CurveEaseInOut, .AllowUserInteraction],
            animations: animations,
            completion: completion)
    }
}
