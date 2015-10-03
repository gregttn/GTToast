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
        let toastView = GTToast.create("")
        
        XCTAssertEqual(toastView.frame, expectedFrame())
    }
    
    private func expectedFrame() -> CGRect {
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let padding: CGFloat = 5.0
        let height: CGFloat = 60.0
        let yOffset: CGFloat = screenSize.height - height - padding
        
        return CGRectMake(padding, yOffset, screenSize.width - 2 * padding, height)
    }
}
