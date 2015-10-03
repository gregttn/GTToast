//
//  GTToastView.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToastView: UIView {
    public var messageLabel: UILabel!
    private let labelMargin: CGFloat = 3.0

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
        let totalMargin: CGFloat = 2 * labelMargin
        let label = UILabel(frame: CGRectMake(labelMargin, labelMargin, frame.size.width
            - totalMargin, frame.size.height - totalMargin))
        
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
