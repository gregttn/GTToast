import UIKit
import XCTest
import GTToast

class GTToastViewTests: XCTestCase {
    private var toast: GTToastView!
    
    let margin: CGFloat = 5.0
    let contentInset: CGFloat = 3.0
    let imageMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
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
    
    
    func testInit_shouldAlignLabelAccordingToSettings() {
        let config = GTToastConfig(textAlignment: NSTextAlignment.Left)
        toast = GTToastView(message: "", config: config)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.textAlignment, NSTextAlignment.Left)
    }
    
    func testInit_shouldShiftLabelWhenImageViewPresent() {
        let image = UIImage(named: "tick")
        toast = GTToastView(message: "", config: config, image: image!)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let messageLabel = toast.subviews[0]
        let imageRightMargin:CGFloat = 5
        
        let expectedFrame = CGRectMake(contentInset + image!.size.width + imageRightMargin,
            contentInset,
            toast.frame.width - contentInset - image!.size.width - imageRightMargin - contentInset,
            94)
        
        XCTAssertTrue(messageLabel .isKindOfClass(UILabel))
        XCTAssertEqual(messageLabel.frame, expectedFrame)
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrameWhenImageOnTheRight() {
        let image = UIImage(named: "tick")
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.Right)
        toast = GTToastView(message: "", config: config, image: image!)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let messageLabel = toast.subviews[0]
        
        XCTAssertTrue(messageLabel .isKindOfClass(UILabel))
        XCTAssertEqual(messageLabel.frame, CGRectMake(3.0, 3.0, 94.0 - image!.size.width -  imageMargins.left - imageMargins.right, 94.0))
    }
    
    func testInit_shouldHaveImageViewWhenImageProvided() {
        let image = UIImage(named: "tick")
        toast = GTToastView(message: "", config: config, image: image!)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let imageView = toast.subviews[1]
        
        XCTAssertTrue(imageView .isKindOfClass(UIImageView))
        XCTAssertEqual(imageView.frame, CGRectMake(3.0, 3.0, image!.size.width, 94.0))
    }
    
    func testInit_shouldHaveImageViewOnTheRight() {
        let image = UIImage(named: "tick")
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.Right)
        toast = GTToastView(message: "", config: config, image: image!)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let imageView = toast.subviews[1]
        
        let expectedX: CGFloat = toast.frame.size.width - contentInset - imageMargins.right - image!.size.width
        XCTAssertTrue(imageView .isKindOfClass(UIImageView))
        XCTAssertEqual(imageView.frame, CGRectMake(expectedX, 8, image!.size.width, 82.0))
    }
    
    func testInit_shouldRespectImageInsetsWhenCreatingImageView() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 10)
        let image = UIImage(named: "tick")
        toast = GTToastView(message: "", config: GTToastConfig(imageMargins: imageMargins), image: image!)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let imageView = toast.subviews[1]
        
        XCTAssertTrue(imageView .isKindOfClass(UIImageView))
        XCTAssertEqual(imageView.frame, CGRectMake(3.0 + imageMargins.left, 3.0 + imageMargins.top, image!.size.width, 94.0 - imageMargins.bottom - imageMargins.top))
    }
    
    func testInit_shouldAssignImageToImageView() {
        let image = UIImage(named: "tick")
        toast = GTToastView(message: "", config: config, image: image!)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let imageView: UIImageView = toast.subviews[1] as! UIImageView
        
        XCTAssertEqual(imageView.image!, image)
    }
    
    func testInit_imageViewShouldHaveCorrectAspectRatio() {
        let image = UIImage(named: "tick")
        toast = GTToastView(message: "", config: config, image: image!)
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        let imageView: UIImageView = toast.subviews[1] as! UIImageView
        
        XCTAssertEqual(imageView.contentMode, UIViewContentMode.ScaleAspectFit)
    }
    
    func testInit_shouldNotAddImageViewWhenNoImage() {
        toast.frame = CGRectMake(100, 100, 100, 100)
        
        XCTAssertFalse(toast.subviews.contains({ $0.isKindOfClass(UIImageView) }))
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
    
    func testShow_shouldAddViewToWindowWhenSlideInAnimationSelected() {
        toast.show()
        
        XCTAssertTrue(window().subviews.contains(toast))
    }
    
    func testShow_shouldRemoveViewFromWindowAfterDelayWhenSlideInAnimationSelected() {
        let config = GTToastConfig(displayInterval: 0.1)
        
        toast = GTToastView(message: "",config: config)
        toast.frame = frame
        toast.show()
        
        NSRunLoop.currentRunLoop().runUntilDate(NSDate().dateByAddingTimeInterval(1.5))
        
        XCTAssertFalse(window().subviews.contains(toast))
    }
    
    func testShow_shouldAddViewToWindowWhenAlphaAnimationSelected() {
        let config = GTToastConfig(animation: GTToastAnimation.Alpha)
        
        toast = GTToastView(message: "",config: config)
        toast.frame = frame
        toast.show()
        
        XCTAssertTrue(window().subviews.contains(toast))
    }
    
    func testShow_shouldRemoveViewFromWindowAfterDelayWhenAlphaAnimationSelected() {
        let config = GTToastConfig(displayInterval: 0.1, animation: GTToastAnimation.Alpha)
        
        toast = GTToastView(message: "",config: config)
        toast.frame = frame
        toast.show()
        
        NSRunLoop.currentRunLoop().runUntilDate(NSDate().dateByAddingTimeInterval(1.5))
        
        XCTAssertFalse(window().subviews.contains(toast))
    }
    
    func testSizeThatFits_shouldReturnAppropriateSize() {
        let labelSize = calculateLabelSize()
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset,
            ceil(labelSize.height) + 2 * contentInset)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    func testSizeThatFits_shouldIncludeSizeOfTheImageWhenPresent() {
        let image = UIImage(named: "tick")
        let labelSize = calculateLabelSize(image!.size.width + imageMargins.right)
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset + image!.size.width + imageMargins.right,
            ceil(labelSize.height) + 2 * contentInset)
        
        toast = GTToastView(message: "", config: config, image: image!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    func testSizeThatFits_shouldRestrictSizeOfTheImageTo100() {
        let image = UIImage(named: "bell")
        let labelSize = calculateLabelSize(100 + imageMargins.right)
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset + 100 + imageMargins.right,
            ceil(labelSize.height) + 2 * contentInset)
    
        toast = GTToastView(message: "", config: config, image: image!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    func testSizeThatFits_shouldIncludeImageInsetsWhenCalculatingSize() {
        let imageMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let image = UIImage(named: "bell")
        let labelSize = calculateLabelSize(100 + imageMargins.right + imageMargins.left)
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset + 100 + imageMargins.right + imageMargins.left,
            ceil(labelSize.height) + 2 * contentInset + imageMargins.top + imageMargins.bottom)
        
        toast = GTToastView(message: "", config: GTToastConfig(imageMargins: imageMargins), image: image!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    private func calculateLabelSize(imageTotalWidth: CGFloat = 0) -> CGSize {
        let screenSize = UIScreen.mainScreen().bounds.size
        
        return NSString(string: "").boundingRectWithSize(
            CGSizeMake(screenSize.width - 2 * margin - 2 * contentInset - imageTotalWidth, 0),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName : UIFont.systemFontOfSize(12.0)],
            context: nil)
            .size
    }
    
    private func window() -> UIWindow {
        return UIApplication.sharedApplication().windows.first!
    }
}
