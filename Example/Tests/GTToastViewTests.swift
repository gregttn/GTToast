import UIKit
import XCTest
import GTToast

class GTToastViewTests: XCTestCase {
    fileprivate var toast: GTToastView!
    
    let margin: CGFloat = 5.0
    let contentInset: CGFloat = 3.0
    let imageMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
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
        let expectedColor = UIColor.black.withAlphaComponent(0.8)
        
        XCTAssertEqual(toast.backgroundColor!, expectedColor)
    }
    
    func testInit_shouldHaveCorrectBackgroundColor() {
        let config = GTToastConfig(backgroundColor: UIColor.red.withAlphaComponent(0.5))
        
        updateToast(config: config)
        
        let expectedColor = UIColor.red.withAlphaComponent(0.5)

        XCTAssertEqual(toast.backgroundColor!, expectedColor)
    }
    
    func testInit_shouldHaveRoundedCorners() {
        XCTAssertEqual(toast.layer.cornerRadius, CGFloat(3.0))
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrame() {
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        let messageLabel = toast.subviews[0]
        
        XCTAssertTrue(messageLabel .isKind(of:UILabel.self))
        XCTAssertEqual(messageLabel.frame, CGRect(x: 3.0, y: 3.0, width: 94.0, height: 94.0))
    }
    
    
    func testInit_shouldAlignLabelAccordingToSettings() {
        let config = GTToastConfig(textAlignment: NSTextAlignment.left)
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config)
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.textAlignment, NSTextAlignment.left)
    }
    
    func testInit_shouldShiftLabelWhenImageViewPresent() {
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: GTToastConfig(imageMargins: UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 5)), image: smallImage!)

        let messageLabel = toast.subviews[0]
        let imageRightMargin:CGFloat = 5
        
        let expectedFrame = CGRect(x: contentInset + smallImage!.size.width + imageRightMargin,
            y: contentInset,
            width: toast.frame.width - contentInset - smallImage!.size.width - imageRightMargin - contentInset,
            height: 94)
        
        XCTAssertTrue(messageLabel .isKind(of:UILabel.self))
        XCTAssertEqual(messageLabel.frame, expectedFrame)
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrameWhenImageOnTheRight() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.right)
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let messageLabel = toast.subviews[0]
        
        XCTAssertTrue(messageLabel .isKind(of:UILabel.self))
        XCTAssertEqual(messageLabel.frame, CGRect(x: 3.0, y: 3.0, width: 94.0 - smallImage!.size.width -  imageMargins.left - imageMargins.right, height: 94.0))
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrameWhenImageOnTop() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.top)
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let messageLabel = toast.subviews[0]
        
        let expectedFrame = CGRect(
            x: contentInset,
            y: contentInset + imageMargins.top + smallImage!.size.height + imageMargins.bottom,
            width: toast.frame.size.width - 2 * contentInset,
            height: toast.frame.size.height - 2 * contentInset - imageMargins.top - imageMargins.bottom - smallImage!.size.height
        )
        
        XCTAssertTrue(messageLabel .isKind(of:UILabel.self))
        XCTAssertEqual(messageLabel.frame, expectedFrame)
    }
    
    func testInit_shouldHaveMessageLabelWithCorrectFrameWhenImageOnTheBottom() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.bottom)
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let messageLabel = toast.subviews[0]
        
        let expectedFrame = CGRect(
            x: contentInset,
            y: contentInset,
            width: toast.frame.size.width - 2 * contentInset,
            height: toast.frame.size.height - 2 * contentInset - imageMargins.top - imageMargins.bottom - smallImage!.size.height
        )
        
        XCTAssertTrue(messageLabel .isKind(of:UILabel.self))
        XCTAssertEqual(messageLabel.frame, expectedFrame)
    }
    
    func testInit_shouldHaveImageViewWhenImageProvided() {
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        XCTAssertTrue(imageView .isKind(of:UIImageView.self))
        XCTAssertEqual(imageView.frame, CGRect(x: 3.0, y: 3.0, width: smallImage!.size.width, height: 94.0))
    }
    
    func testInit_shouldHaveImageViewOnTheRight() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.right)
        
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        let expectedX: CGFloat = toast.frame.size.width - contentInset - imageMargins.right - smallImage!.size.width
        XCTAssertTrue(imageView .isKind(of:UIImageView.self))
        XCTAssertEqual(imageView.frame, CGRect(x: expectedX, y: 8, width: smallImage!.size.width, height: 82.0))
    }
    
    func testInit_shouldHaveImageViewOnTop() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.top)
        
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        let expectedFrame = CGRect(
            x: contentInset + imageMargins.left,
            y: contentInset + imageMargins.top,
            width: toast.frame.size.width - contentInset - imageMargins.left - imageMargins.right - contentInset,
            height: smallImage!.size.height
        )
        
        XCTAssertTrue(imageView .isKind(of:UIImageView.self))
        XCTAssertEqual(imageView.frame, expectedFrame)
    }
    
    func testInit_shouldHaveImageViewOnTheBottom() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
        let message = "Some message"
        let config = GTToastConfig(imageMargins: imageMargins, imageAlignment: GTToastAlignment.bottom)
        
        updateToast(message,frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        let expectedFrame = CGRect(
            x: contentInset + imageMargins.left,
            y: contentInset + imageMargins.top + ceil(calculateLabelSize(message).height),
            width: toast.frame.size.width - contentInset - imageMargins.left - imageMargins.right - contentInset,
            height: smallImage!.size.height
        )
        
        XCTAssertTrue(imageView .isKind(of:UIImageView.self))
        XCTAssertEqual(imageView.frame, expectedFrame)
    }
    
    func testInit_shouldRespectImageInsetsWhenCreatingImageView() {
        let imageMargins = UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 10)
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: GTToastConfig(imageMargins: imageMargins), image: smallImage!)
        
        let imageView = toast.subviews[1]
        
        XCTAssertTrue(imageView .isKind(of:UIImageView.self))
        XCTAssertEqual(imageView.frame, CGRect(x: 3.0 + imageMargins.left, y: 3.0 + imageMargins.top, width: smallImage!.size.width, height: 94.0 - imageMargins.bottom - imageMargins.top))
    }
    
    func testInit_shouldAssignImageToImageView() {
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let imageView: UIImageView = toast.subviews[1] as! UIImageView
        
        XCTAssertEqual(imageView.image!, smallImage)
    }
    
    func testInit_imageViewShouldHaveCorrectAspectRatio() {
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100), config: config, image: smallImage!)
        
        let imageView: UIImageView = toast.subviews[1] as! UIImageView
        
        XCTAssertEqual(imageView.contentMode, UIViewContentMode.scaleAspectFit)
    }
    
    func testInit_shouldNotAddImageViewWhenNoImage() {
        updateToast(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        XCTAssertFalse(toast.subviews.contains(where: { $0.isKind(of:UIImageView.self) }))
    }
    
    func testInit_messageLabelShouldHaveTransparentBackground() {
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.backgroundColor!, UIColor.clear)
    }
    
    func testInit_messageLabelTextShouldBeCorrectlyDisplayed() {
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.textColor, UIColor.white)
        XCTAssertEqual(messageLabel.textAlignment, NSTextAlignment.center)
        XCTAssertEqual(messageLabel.font, UIFont.systemFont(ofSize: 12.0))
        XCTAssertEqual(messageLabel.numberOfLines, 0)
    }
    
    func testInit_shouldChangeTheFont() {
        let expectedFont = UIFont.systemFont(ofSize: 24.0)
        let config = GTToastConfig(font: expectedFont)
        
        updateToast(config: config)
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.font, expectedFont)
    }
    
    func testInit_shouldChangeTextColor() {
        let config = GTToastConfig(textColor: UIColor.red)
        updateToast(config: config)
        
        let messageLabel = toast.subviews[0] as! UILabel
        
        XCTAssertEqual(messageLabel.textColor, UIColor.red)
    }
    
    func testInit_shouldHaveAutoresizingMaskSetToHandleRotation() {
        let messageLabel = toast.subviews[0] as! UILabel
        let expectedMasks: UIViewAutoresizing = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin]
        
        XCTAssertEqual(messageLabel.autoresizingMask, expectedMasks)
    }
    
    func testInit_messageLableshouldHaveAutoresizingMaskSetToHandleRotation() {
        let expectedMasks: UIViewAutoresizing = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin]
        
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
        
        RunLoop.current.run(until: Date().addingTimeInterval(1.5))
        
        XCTAssertFalse(window().subviews.contains(toast))
    }
    
    func testShow_shouldAddViewToWindowWhenAlphaAnimationSelected() {
        let config = GTToastConfig(animation: GTAlphaAnimation())
        
        updateToast(config: config)
        
        toast.show()
        
        XCTAssertTrue(window().subviews.contains(toast))
    }
    
    func testShow_shouldRemoveViewFromWindowAfterDelayWhenAlphaAnimationSelected() {
        let config = GTToastConfig(animation: GTAlphaAnimation(), displayInterval: 0.1)
        
        updateToast(config: config)
        
        toast.show()
        
        RunLoop.current.run(until: Date().addingTimeInterval(1.5))
        
        XCTAssertFalse(window().subviews.contains(toast))
    }
    
    func testDismiss_shouldRemoveView() {
        let config = GTToastConfig(displayInterval: 10)
        
        updateToast(config: config)
        toast.show()
        
        RunLoop.current.run(until: Date().addingTimeInterval(1.5))
        
        XCTAssertTrue(window().subviews.contains(toast))
        
        toast.dismiss()
        
        RunLoop.current.run(until: Date().addingTimeInterval(1))
        
        XCTAssertFalse(window().subviews.contains(toast))
    }
    
    func testDismiss_shouldNotAttemptToDismissIfNotShown() {
        let config = GTToastConfig(displayInterval: 1)
        
        updateToast(config: config)
        toast.dismiss()
        
        RunLoop.current.run(until: Date().addingTimeInterval(1.5))
        
        XCTAssertFalse(window().subviews.contains(toast))
    }
    
    func testSizeThatFits_shouldReturnAppropriateSize() {
        let labelSize = calculateLabelSize()
        let expectedSize = CGSize(width: ceil(labelSize.width) + 2 * contentInset,
            height: ceil(labelSize.height) + 2 * contentInset)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldIncludeSizeOfTheImageWhenPresent() {
        let labelSize = calculateLabelSize(imageTotalWidth: smallImage!.size.width + imageMargins.right)
        let expectedSize = CGSize(width: ceil(labelSize.width) + 2 * contentInset + smallImage!.size.width + imageMargins.right,
            height: ceil(labelSize.height) + 2 * contentInset)
        
        toast = GTToastView(message: "", config: config, image: smallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldRestrictSizeOfTheImageTo100() {
        let labelSize = calculateLabelSize(imageTotalWidth: 100 + imageMargins.right)
        let expectedSize = CGSize(width: ceil(labelSize.width) + 2 * contentInset + 100 + imageMargins.right,
            height: ceil(labelSize.height) + 2 * contentInset)
    
        updateToast(config: GTToastConfig(imageMargins: imageMargins), image: bigImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldRestrictSizeOfTheImageToProvidedAmount() {
        let config = GTToastConfig(imageMargins: imageMargins, maxImageSize: CGSize(width: 50, height: 100))
        let labelSize = calculateLabelSize(imageTotalWidth: 50 + imageMargins.right)
        let expectedSize = CGSize(width: ceil(labelSize.width) + 2 * contentInset + 50 + imageMargins.right,
            height: ceil(labelSize.height) + 2 * contentInset)
        
        updateToast(config: config, image: bigImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldIncludeImageInsetsWhenCalculatingSize() {
        let imageMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let labelSize = calculateLabelSize(imageTotalWidth: 100 + imageMargins.right + imageMargins.left)
        let expectedSize = CGSize(width: ceil(labelSize.width) + 2 * contentInset + 100 + imageMargins.right + imageMargins.left,
            height: ceil(labelSize.height) + 2 * contentInset)
        
        updateToast(config: GTToastConfig(imageMargins: imageMargins), image: bigImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldCalculateAppropriateFrameWhenImageOnTop() {
        let veryLongMessage = "This is very long message, longer images width"
        let labelSize = calculateLabelSize(veryLongMessage, imageTotalWidth: 0)
        let expectedSize = CGSize(
            width: ceil(labelSize.width) + 2 * contentInset,
            height: ceil(labelSize.height) + 2 * contentInset + smallImage!.size.height + imageMargins.top + imageMargins.bottom
        )
        
        toast = GTToastView(message: veryLongMessage, config: GTToastConfig(imageAlignment: .top), image: smallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldCalculateAppropriateFrameWhenImageOnTheBottom() {
        let veryLongMessage = "This is very long message, longer images width"
        let labelSize = calculateLabelSize(veryLongMessage, imageTotalWidth: 0)
        let expectedSize = CGSize(
            width: ceil(labelSize.width) + 2 * contentInset,
            height: ceil(labelSize.height) + 2 * contentInset + smallImage!.size.height + imageMargins.top + imageMargins.bottom
        )
        
        toast = GTToastView(message: veryLongMessage, config: GTToastConfig(imageAlignment: .bottom), image: smallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldRestrictImageHeightTo200WhenOnTop() {
        let veryLongMessage = "This is very long message, longer images width"
        let labelSize = calculateLabelSize(veryLongMessage, imageTotalWidth: 0)
        let expectedSize = CGSize(
            width: ceil(labelSize.width) + 2 * contentInset,
            height: ceil(labelSize.height) + 2 * contentInset + 200 + imageMargins.top + imageMargins.bottom
        )
        
        toast = GTToastView(message: veryLongMessage, config: GTToastConfig(imageAlignment: .top), image: tallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    func testSizeThatFits_shouldRestrictImageHeightToSpecifiedAmountWhenImageOnTop() {
        let config = GTToastConfig(imageAlignment: .top, maxImageSize: CGSize(width: 100, height: 300))
        let veryLongMessage = "This is very long message, longer images width"
        let labelSize = calculateLabelSize(veryLongMessage, imageTotalWidth: 0)
        let expectedSize = CGSize(
            width: ceil(labelSize.width) + 2 * contentInset,
            height: ceil(labelSize.height) + 2 * contentInset + 300 + imageMargins.top + imageMargins.bottom
        )
        
        toast = GTToastView(message: veryLongMessage, config: config, image: tallImage!)
        
        XCTAssertEqual(toast.sizeThatFits(CGSize.zero), expectedSize)
    }
    
    fileprivate func calculateLabelSize(_ message: String = "", imageTotalWidth: CGFloat = 0) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        
        return NSString(string: message).boundingRect(
            with: CGSize(width: screenSize.width - 2 * margin - 2 * contentInset - imageTotalWidth, height: 0),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)],
            context: nil)
            .size
    }
    
    fileprivate func updateToast(_ message: String = "", frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), config: GTToastConfig = GTToastConfig(), image: UIImage? = .none) {
        toast = GTToastView(message: "", config: config, image: image)
        toast.frame = frame
        
    }
    
    fileprivate func window() -> UIWindow {
        return UIApplication.shared.windows.first!
    }
}
