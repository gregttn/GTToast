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
    let smallImage = UIImage(named: "tick")
    let bigImage = UIImage(named: "bell")
    let tallImage = UIImage(named: "tallImage")
    
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
        XCTAssertEqual(toast.frame, frame)
    }
    
    func testInit_shouldHaveBlackBackgroundWhenNotProvided() {
        let expectedColor = UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor
        
        XCTAssertTrue(CGColorEqualToColor(toast.backgroundColor?.CGColor, expectedColor))
    }
    
    func testInit_shouldHaveCorrectBackgroundColor() {
        let config = GTToastConfig(backgroundColor: UIColor.redColor().colorWithAlphaComponent(0.5))
        
        updateToast(config: config)
        
        let expectedColor = UIColor.redColor().colorWithAlphaComponent(0.5).CGColor

        XCTAssertTrue(CGColorEqualToColor(toast.backgroundColor?.CGColor, expectedColor))
    }
    
    func testInit_shouldHaveRoundedCorners() {
        XCTAssertEqual(toast.layer.cornerRadius, CGFloat(3.0))
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrame() {
        updateToast(frame: CGRectMake(100, 100, 100, 100))
        
        let messageLabel = toast.subviews[0]
        
        XCTAssertTrue(messageLabel .isKindOfClass(UILabel))
        XCTAssertEqual(messageLabel.frame, CGRectMake(3.0, 3.0, 94.0, 94.0))
    }
    
    
    func testInit_shouldAlignLabelAccordingToSettings() {
        let config = GTToastConfig(textAlignment: NSTextAlignment.Left)
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: config)
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.textAlignment, NSTextAlignment.Left)
    }
    
    func testInit_shouldShiftLabelWhenImageViewPresent() {
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: config, image: smallImage!)

        let messageLabel = toast.subviews[0]
        let imageRightMargin:CGFloat = 5
        
        let expectedFrame = CGRectMake(contentInset + smallImage!.size.width + imageRightMargin,
            contentInset,
            toast.frame.width - contentInset - smallImage!.size.width - imageRightMargin - contentInset,
            94)
        
        XCTAssertTrue(messageLabel .isKindOfClass(UILabel))
        XCTAssertEqual(messageLabel.frame, expectedFrame)
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrameWhenImageOnTheRight() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.Right)
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: config, image: smallImage!)
        
        let messageLabel = toast.subviews[0]
        
        XCTAssertTrue(messageLabel .isKindOfClass(UILabel))
        XCTAssertEqual(messageLabel.frame, CGRectMake(3.0, 3.0, 94.0 - smallImage!.size.width -  imageMargins.left - imageMargins.right, 94.0))
    }
    
    func testInit_shouldHaveImageViewWhenImageProvided() {
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: config, image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        XCTAssertTrue(imageView .isKindOfClass(UIImageView))
        XCTAssertEqual(imageView.frame, CGRectMake(3.0, 3.0, smallImage!.size.width, 94.0))
    }
    
    func testInit_shouldHaveImageViewOnTheRight() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.Right)
        
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: config, image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        let expectedX: CGFloat = toast.frame.size.width - contentInset - imageMargins.right - smallImage!.size.width
        XCTAssertTrue(imageView .isKindOfClass(UIImageView))
        XCTAssertEqual(imageView.frame, CGRectMake(expectedX, 8, smallImage!.size.width, 82.0))
    }
    
    func testInit_shouldRespectImageInsetsWhenCreatingImageView() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 10)
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: GTToastConfig(imageMargins: imageMargins), image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        XCTAssertTrue(imageView .isKindOfClass(UIImageView))
        XCTAssertEqual(imageView.frame, CGRectMake(3.0 + imageMargins.left, 3.0 + imageMargins.top, smallImage!.size.width, 94.0 - imageMargins.bottom - imageMargins.top))
    }
    
    func testInit_shouldAssignImageToImageView() {
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: config, image: smallImage!)
        
        let imageView: UIImageView = toast.subviews[1] as! UIImageView
        
        XCTAssertEqual(imageView.image!, smallImage)
    }
    
    func testInit_imageViewShouldHaveCorrectAspectRatio() {
        updateToast(frame: CGRectMake(100, 100, 100, 100), config: config, image: smallImage!)
        
        let imageView: UIImageView = toast.subviews[1] as! UIImageView
        
        XCTAssertEqual(imageView.contentMode, UIViewContentMode.ScaleAspectFit)
    }
    
    func testInit_shouldNotAddImageViewWhenNoImage() {
        updateToast(frame: CGRectMake(100, 100, 100, 100))
        
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
        
        updateToast(config: config)
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.font, expectedFont)
    }
    
    func testInit_shouldChangeTextColor() {
        let config = GTToastConfig(textColor: UIColor.redColor())
        updateToast(config: config)
        
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
        
        updateToast(config: config)
        toast.show()
        
        NSRunLoop.currentRunLoop().runUntilDate(NSDate().dateByAddingTimeInterval(1.5))
        
        XCTAssertFalse(window().subviews.contains(toast))
    }
    
    func testShow_shouldAddViewToWindowWhenAlphaAnimationSelected() {
        let config = GTToastConfig(animation: GTToastAnimation.Alpha)
        
        updateToast(config: config)
        
        toast.show()
        
        XCTAssertTrue(window().subviews.contains(toast))
    }
    
    func testShow_shouldRemoveViewFromWindowAfterDelayWhenAlphaAnimationSelected() {
        let config = GTToastConfig(displayInterval: 0.1, animation: GTToastAnimation.Alpha)
        
        updateToast(config: config)
        
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
        let labelSize = calculateLabelSize(imageTotalWidth: smallImage!.size.width + imageMargins.right)
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset + smallImage!.size.width + imageMargins.right,
            ceil(labelSize.height) + 2 * contentInset)
        
        toast = GTToastView(message: "", config: config, image: smallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    func testSizeThatFits_shouldRestrictSizeOfTheImageTo100() {
        let labelSize = calculateLabelSize(imageTotalWidth: 100 + imageMargins.right)
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset + 100 + imageMargins.right,
            ceil(labelSize.height) + 2 * contentInset)
    
        updateToast(config: GTToastConfig(imageMargins: imageMargins), image: bigImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    func testSizeThatFits_shouldIncludeImageInsetsWhenCalculatingSize() {
        let imageMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let labelSize = calculateLabelSize(imageTotalWidth: 100 + imageMargins.right + imageMargins.left)
        let expectedSize = CGSizeMake(ceil(labelSize.width) + 2 * contentInset + 100 + imageMargins.right + imageMargins.left,
            ceil(labelSize.height) + 2 * contentInset)
        
        updateToast(config: GTToastConfig(imageMargins: imageMargins), image: bigImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    func testSizeThatFits_shouldCalculateAppropriateFrameWhenImageOnTop() {
        let veryLongMessage = "This is very long message, longer images width"
        let labelSize = calculateLabelSize(veryLongMessage, imageTotalWidth: 0)
        let expectedSize = CGSizeMake(
            ceil(labelSize.width) + 2 * contentInset,
            ceil(labelSize.height) + 2 * contentInset + smallImage!.size.height + imageMargins.top + imageMargins.bottom
        )
        
        toast = GTToastView(message: veryLongMessage, config: GTToastConfig(imageAlignment: .Top), image: smallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    func testSizeThatFits_shouldRestrictImageHeightTo200WhenOnTop() {
        let veryLongMessage = "This is very long message, longer images width"
        let labelSize = calculateLabelSize(veryLongMessage, imageTotalWidth: 0)
        let expectedSize = CGSizeMake(
            ceil(labelSize.width) + 2 * contentInset,
            ceil(labelSize.height) + 2 * contentInset + 200 + imageMargins.top + imageMargins.bottom
        )
        
        toast = GTToastView(message: veryLongMessage, config: GTToastConfig(imageAlignment: .Top), image: tallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSizeZero), expectedSize)
    }
    
    private func calculateLabelSize(message: String = "", imageTotalWidth: CGFloat = 0) -> CGSize {
        let screenSize = UIScreen.mainScreen().bounds.size
        
        return NSString(string: message).boundingRectWithSize(
            CGSizeMake(screenSize.width - 2 * margin - 2 * contentInset - imageTotalWidth, 0),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName : UIFont.systemFontOfSize(12.0)],
            context: nil)
            .size
    }
    
    private func updateToast(message: String = "", frame: CGRect = CGRectMake(0, 0, 100, 100), config: GTToastConfig = GTToastConfig(), image: UIImage? = .None) {
        toast = GTToastView(message: "", config: config, image: image)
        toast.frame = frame
        
    }
    
    private func window() -> UIWindow {
        return UIApplication.sharedApplication().windows.first!
    }
}
