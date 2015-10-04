//
//  GTToast.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 03/10/2015.
//
//

public class GTToast {
    private static let margin: CGFloat = 5.0
    
    public static func create(message: String) -> GTToastView {
        let config = GTToastConfig(message: message)
        let toast = GTToastView(frame: createFrame(config), config: config)
        
        return toast
    }
    
    private static func createFrame(config: GTToastConfig) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds
        
        let maxLabelWidth = screenSize.width - 2 * GTToast.margin - config.contentInsets.left - config.contentInsets.right
        let labelSize = config.font.sizeFor(config.message, constrain: CGSizeMake(maxLabelWidth, 0))
        
        let height = ceil(labelSize.height) + config.contentInsets.top + config.contentInsets.bottom
        let width = ceil(labelSize.width) + config.contentInsets.left + config.contentInsets.right
        let y = screenSize.height - GTToast.margin - height
        let x = ceil((screenSize.width - width) / 2.0)
        
        return CGRectMake(x, y, width, height)
    }
}

public struct GTToastConfig {
    static let defaultInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)
    static let defaultFont = UIFont.systemFontOfSize(12.0)
    
    let message: String
    let contentInsets: UIEdgeInsets
    let font: UIFont
    let textColor: UIColor
    let backgroundColor: UIColor
    
    public init(message: String,
        contentInsets: UIEdgeInsets = GTToastConfig.defaultInsets,
        font: UIFont = GTToastConfig.defaultFont,
        textColor: UIColor = UIColor.whiteColor(),
        backgroundColor: UIColor = UIColor.blackColor())
    {
        
        self.message = message
        self.contentInsets = contentInsets
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
