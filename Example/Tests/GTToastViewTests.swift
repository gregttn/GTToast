import UIKit
import XCTest
import GTToast

class GTToastViewTests: XCTestCase {
    private var toast: GTToastView!
    
    let frame = CGRectMake(0, 0, 100, 100)
    let config = GTToastConfig()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        toast = GTToastView(message: "", config: config)
        toast.frame = frame
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown() 
    }
    
    func testInit_shouldHaveCorrectFrame() {
        toast.frame = frame
        
        XCTAssertEqual(toast.frame, frame)
    }
    
    func testInit_shouldHaveBlackBackgroundWhenNotProvided() {
        let expectedColor = UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor
        
        XCTAssertTrue(CGColorEqualToColor(toast.backgroundColor?.CGColor, expectedColor))
    }
    
    func testInit_shouldHaveCorrectBackgroundColor() {
        let config = GTToastConfig(backgroundColor: UIColor.redColor())
        
        toast = GTToastView(message: "",config: config)
        toast.frame = frame
        
        let expectedColor = UIColor.redColor().colorWithAlphaComponent(0.8).CGColor

        XCTAssertTrue(CGColorEqualToColor(toast.backgroundColor?.CGColor, expectedColor))
    }
    
    func testInit_shouldHaveRoundedCorners() {
        XCTAssertEqual(toast.layer.cornerRadius, CGFloat(3.0))
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrame() {
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let messageLabel = toast.subviews[0]
        
        XCTAssertTrue(messageLabel .isKindOfClass(UILabel))
        XCTAssertEqual(messageLabel.frame, CGRectMake(3.0, 3.0, 94.0, 94.0))
    }
    
    func testInit_messageLabelShouldHaveTransparentBackground() {
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertTrue(CGColorEqualToColor(messageLabel.backgroundColor?.CGColor, UIColor.clearColor().CGColor))
    }
    
    func testInit_messageLabelTextShouldBeCorrectlyDisplayed() {
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertTrue(CGColorEqualToColor(messageLabel.textColor.CGColor, UIColor.whiteColor().CGColor))
        XCTAssertEqual(messageLabel.textAlignment, NSTextAlignment.Center)
        XCTAssertEqual(messageLabel.font, UIFont.systemFontOfSize(12.0))
        XCTAssertEqual(messageLabel.numberOfLines, 0)
    }
    
    func testInit_shouldChangeTheFont() {
        let expectedFont = UIFont.systemFontOfSize(24.0)
        let config = GTToastConfig(font: expectedFont)
        
        toast = GTToastView(message: "", config: config)
        toast.frame = frame
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.font, expectedFont)
    }
    
    func testInit_shouldChangeTextColor() {
        let config = GTToastConfig(textColor: UIColor.redColor())
        
        toast = GTToastView(message: "",config: config)
        toast.frame = frame
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertTrue(CGColorEqualToColor(messageLabel.textColor.CGColor, UIColor.redColor().CGColor))
    }
    
    func testInit_shouldHaveAutoresizingMaskSetToHandleRotation() {
        let messageLabel = toast.subviews[0] as! UILabel
        let expectedMasks: UIViewAutoresizing = [UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin]
        
        XCTAssertEqual(messageLabel.autoresizingMask, expectedMasks)
    }
    
    func testInit_messageLableshouldHaveAutoresizingMaskSetToHandleRotation() {
        let expectedMasks: UIViewAutoresizing = [UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin]
        
        XCTAssertEqual(toast.autoresizingMask, expectedMasks)
    }
    
    func testShow_shouldAddViewToWindow() {
        toast.show()
        
        XCTAssertTrue(window().subviews.contains(toast))
    }
    
    func testSizeThatFits_shouldReturnAppropriateSize() {
        let screenSize = UIScreen.mainScreen().bounds.size
        let margin: CGFloat = 5.0
        let contentInset: CGFloat = 3.0
        
        let labelSize = NSString(string: "").boundingRectWithSize(
            CGSizeMake(screenSize.width - 2 * margin - 2 * contentInset, 0),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName : UIFont.systemFontOfSize(12.0)],
            context: nil)
            .size
        
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset,
            ceil(labelSize.height) + 2 * contentInset)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    private func window() -> UIWindow {
        return UIApplication.sharedApplication().windows.first!
    }
}
