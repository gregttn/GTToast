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
    
    private func expectedFrame(message: String) -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let margin: CGFloat = 5.0
        let contentInset: CGFloat = 3.0
        let labelSize = NSString(string: message).boundingRectWithSize(
                CGSizeMake(screenSize.width - 2 * margin - 2 * contentInset, 0),
                options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName : UIFont.systemFontOfSize(12.0)],
                context: nil)
            .size
        
        let height: CGFloat = ceil(labelSize.height) + 2 * contentInset
        let yOffset: CGFloat = screenSize.height - height - margin
        
        return CGRectMake(margin, yOffset, screenSize.width - 2 * margin, height)
    }
}
