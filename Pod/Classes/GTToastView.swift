//
//  GTToastView.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToastView: UIView {
    internal var messageLabel: UILabel!
    internal let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)

    init() {
        fatalError("init(coder:) has not been implemented")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame: CGRect, color: UIColor = UIColor.blackColor()) {
        super.init(frame: frame)
        
        self.backgroundColor = color.colorWithAlphaComponent(0.8)
        self.layer.cornerRadius = 3.0
        
        messageLabel = createLabel()
        addSubview(messageLabel)
    }

    private func createLabel() -> UILabel {
        let labelFrame = CGRectMake(
                contentInsets.left,
                contentInsets.top,
                frame.size.width - contentInsets.right - contentInsets.left,
                frame.size.height - contentInsets.top - contentInsets.right
        )
        
        let label = UILabel(frame: labelFrame)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(12.0)
        
        return label
    }
    
    public func show() {
        let window = UIApplication.sharedApplication().windows.first
        window?.addSubview(self)
    }
}
