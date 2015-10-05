import UIKit
import XCTest
import GTToast

class GTToastTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreate_shouldCreateWithAppropriateFrame() {
        let message = "Test Message"
        let toastView = GTToast.create(message)
        
        XCTAssertEqual(toastView.frame, expectedFrame(message))
    }
    
    func testCreate_shouldCreateWithAppropriateMessage() {
        let message = "Test Message"
        let toastView = GTToast.create(message)
        
        let label = toastView.subviews[0] as! UILabel
        XCTAssertEqual(label.text, message)
    }
    
    func testCreate_shouldCreateWithAppropriateConfig() {
        let config = GTToastConfig(textColor: UIColor.blueColor())
        let toastFactory = GTToast(config: config)
        let message = "Test Message"
        
        let toastView = toastFactory.create(message)
        
        let label = toastView.subviews[0] as! UILabel
        XCTAssertTrue(CGColorEqualToColor(label.textColor.CGColor, UIColor.blueColor().CGColor))
    }
    
    private func expectedFrame(message: String) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let margin: CGFloat = 5.0
        let contentInset: CGFloat = 3.0
        let maxLabelWidth = screenSize.width - 2 * margin - 2 * contentInset
        
        let labelSize = NSString(string: message).boundingRectWithSize(
                CGSizeMake(maxLabelWidth, 0),
                options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName : UIFont.systemFontOfSize(12.0)],
                context: nil)
            .size
        
        let height: CGFloat = ceil(labelSize.height) + 2 * contentInset
        let width: CGFloat = ceil(labelSize.width) + 2 * contentInset
        let yOffset: CGFloat = screenSize.height - height - margin
        let xOffset: CGFloat = ceil((screenSize.width - width) / 2.0)
        
        return CGRectMake(xOffset, yOffset, width, height)
    }
}
