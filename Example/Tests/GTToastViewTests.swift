import UIKit
import XCTest
import GTToast

class GTToastViewTests: XCTestCase {
    private var toast: GTToastView!
    
    let frame = CGRectMake(0, 0, 100, 100)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        toast = GTToastView(frame: frame)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown() 
    }
    
    func testInit_shouldHaveCorrectFrame() {
        toast = GTToastView(frame: frame)
        
        XCTAssertEqual(toast.frame, frame)
    }
    
    func testInit_shouldHaveBlackBackgroundWhenNotProvided() {
        toast = GTToastView(frame: frame)
        
        XCTAssertTrue(CGColorEqualToColor(toast.backgroundColor?.CGColor, UIColor.blackColor().CGColor))
    }
    
    func testInit_shouldHaveCorrectBackgroundColor() {
        toast = GTToastView(frame: frame, color: UIColor.redColor())
        
        XCTAssertTrue(CGColorEqualToColor(toast.backgroundColor?.CGColor, UIColor.redColor().CGColor))
    }
    
    func testShow_shouldAddViewToWindow() {
        toast.show()
        
        XCTAssertTrue(window().subviews.contains(toast))
    }
    
    private func window() -> UIWindow {
        return UIApplication.sharedApplication().windows.first!
    }
}
