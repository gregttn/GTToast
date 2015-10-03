//
//  GTToastView.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToastView: UIView {
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
    }

    public func show() {
        let window = UIApplication.sharedApplication().windows.first
        window?.addSubview(self)
    }
}
