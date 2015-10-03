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

    init() {
        fatalError("init(coder:) has not been implemented")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame: CGRect, config: GTToastConfig) {
        self.config = config
        super.init(frame: frame)
        
        self.backgroundColor = config.backgroundColor.colorWithAlphaComponent(0.8)
        self.layer.cornerRadius = 3.0
        
        messageLabel = createLabel()
        addSubview(messageLabel)
    }

    private func createLabel() -> UILabel {
        let labelFrame = CGRectMake(
                config.contentInsets.left,
                config.contentInsets.top,
                frame.size.width - config.contentInsets.right - config.contentInsets.left,
                frame.size.height - config.contentInsets.top - config.contentInsets.right
        )
        
        let label = UILabel(frame: labelFrame)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.textColor = config.textColor
        label.font = config.font
        label.numberOfLines = 0
        label.text = config.message
        
        return label
    }
    
    public func show() {
        let window = UIApplication.sharedApplication().windows.first
        window?.addSubview(self)
    }
}
