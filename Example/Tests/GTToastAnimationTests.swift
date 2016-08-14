//
//  GTToastAnimationTests.swift
//  GTToast
//
//  Created by Grzegorz Tatarzyn on 07/10/2015.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import XCTest
import GTToast

class GTToastAnimationTests: XCTestCase {
    private var testView: UIView!
    private var screenSize: CGRect!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testView = UIView(frame: CGRectMake(5, 5, 100, 100))
        screenSize = UIScreen.mainScreen().bounds
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlpha_shouldChangeAlphaToZeroWhenBeforeExecuted() {
        let animations = GTAlphaAnimation()
    
        XCTAssertEqual(testView.alpha, 1)
        animations.before(testView)
        XCTAssertEqual(testView.alpha, 0)
    }
    
    func testAlpha_shouldChangeAlphaToOneWhenShowExecuted() {
        let animations = GTAlphaAnimation()
        testView.alpha = 0
        
        animations.show(testView)
        XCTAssertEqual(testView.alpha, 1)
    }

    func testAlpha_shouldChangeAlphaToZeroWhenShowExecuted() {
        let animations = GTAlphaAnimation()
        testView.alpha = 1
        
        animations.hide(testView)
        XCTAssertEqual(testView.alpha, 0)
    }
    
    func testBottomSlideIn_shouldMoveViewBelowTheScreenEdgeWhenBeforeExecuted() {
        let animations = GTBottomSlideInAnimation()
        
        animations.before(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, screenSize.height, 100, 100))
    }
    
    func testBottomSlideIn_shouldMoveViewOnTheScreenWhenShowExecuted() {
        let animations = GTBottomSlideInAnimation()
        testView.transform = CGAffineTransformMakeTranslation(0, screenSize.height)
        
        animations.show(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, 5, 100, 100))
    }
    
    func testBottomSlideIn_shouldMoveViewBelowTheScreenEdgeWhenHideExecuted() {
        let animations = GTBottomSlideInAnimation()
        
        animations.hide(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, screenSize.height, 100, 100))
    }
    
    func testLeftSlideIn_shouldMoveViewAfterTheLeftScreenEdgeWhenBeforeExecuted() {
        let animations = GTLeftSlideInAnimation()
        
        animations.before(testView)
        XCTAssertEqual(testView.frame, CGRectMake(-100, 5, 100, 100))
    }
    
    func testLeftSlideIn_shouldMoveViewOnTheScreenWhenShowExecuted() {
        let animations = GTLeftSlideInAnimation()
        testView.transform = CGAffineTransformMakeTranslation(-screenSize.width+testView.frame.width, 0)
        
        animations.show(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, 5, 100, 100))
    }

    func testLeftSlideIn_shouldMoveViewAfterTheLeftScreenEdgeWhenHideExecuted() {
        let animations = GTLeftSlideInAnimation()
        
        animations.hide(testView)
        XCTAssertEqual(testView.frame, CGRectMake(-100, 5, 100, 100))
    }
    
    func testRightSlideIn_shouldMoveViewAfterTheRightScreenEdgeWhenBeforeExecuted() {
        let animations = GTRightSlideInAnimation()
        
        animations.before(testView)
        XCTAssertEqual(testView.frame, CGRectMake(screenSize.width, 5, 100, 100))
    }
    
    func testRightSlideIn_shouldMoveViewOnTheScreenWhenShowExecuted() {
        let animations = GTRightSlideInAnimation()
        testView.transform =  CGAffineTransformMakeTranslation(screenSize.width-testView.frame.origin.x, 0)
        
        animations.show(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, 5, 100, 100))
    }
    
    func testRightSlideIn_shouldMoveViewAfterTheRightScreenEdgeWhenHideExecuted() {
        let animations = GTRightSlideInAnimation()
        
        animations.hide(testView)
        XCTAssertEqual(testView.frame, CGRectMake(screenSize.width, 5, 100, 100))
    }
    
    func testScale_shouldMakeViewVerySmallWhenBeforeExecuted() {
        let animations = GTScaleAnimation()
        
        animations.before(testView)
        XCTAssertEqualWithAccuracy(testView.frame.width, 0, accuracy: 0.000001)
        XCTAssertEqualWithAccuracy(testView.frame.height, 0, accuracy: 0.000001)
    }
    
    func testScale_shouldBringBackProperSizeWhenShowExecuted() {
        let animations = GTScaleAnimation()
        testView.transform =  CGAffineTransformMakeScale(0.00001, 0.00001)
        
        XCTAssertNotEqual(testView.frame, CGRectMake(5, 5, 100, 100))
        animations.show(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, 5, 100, 100))
    }
    
    func testScale_shouldMakeViewVerySmallWhenHideExecuted() {
        let animations = GTScaleAnimation()
        
        XCTAssertEqual(testView.frame, CGRectMake(5, 5, 100, 100))
        animations.hide(testView)
        XCTAssertEqualWithAccuracy(testView.frame.width, 0, accuracy: 0.000001)
        XCTAssertEqualWithAccuracy(testView.frame.height, 0, accuracy: 0.000001)
    }
    
    func testLeftInRightOut_shouldMoveViewAfterTheLeftScreenEdgeWhenBeforeExecuted() {
        let animations = GTLeftInRightOutAnimation()
        
        animations.before(testView)
        XCTAssertEqual(testView.frame, CGRectMake(-100, 5, 100, 100))
    }
    
    func testLeftInRightOut_shouldMoveViewOnTheScreenWhenShowExecuted() {
        let animations = GTLeftInRightOutAnimation()
        testView.transform = CGAffineTransformMakeTranslation(-screenSize.width+testView.frame.width, 0)
        
        animations.show(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, 5, 100, 100))
    }
    
    func testLeftInRightOut_shouldMoveViewAfterTheRightScreenEdgeWhenHideExecuted() {
        let animations = GTLeftInRightOutAnimation()
        
        animations.hide(testView)
        XCTAssertEqual(testView.frame, CGRectMake(screenSize.width, 5, 100, 100))
    }
    
    func testRightInLeftOut_shouldMoveViewAfterTheRightScreenEdgeWhenBeforeExecuted() {
        let animations = GTRightInLeftOutAnimation()
        
        animations.before(testView)
        XCTAssertEqual(testView.frame, CGRectMake(screenSize.width, 5, 100, 100))
    }
    
    func testRightInLeftOut_shouldMoveViewOnTheScreenWhenShowExecuted() {
        let animations = GTRightInLeftOutAnimation()
        testView.transform = CGAffineTransformMakeTranslation(-screenSize.width+testView.frame.width, 0)
        
        animations.show(testView)
        XCTAssertEqual(testView.frame, CGRectMake(5, 5, 100, 100))
    }
    
    func testRightInLeftOu_shouldMoveViewAfterTheLeftScreenEdgeWhenHideExecuted() {
        let animations = GTRightInLeftOutAnimation()
        
        animations.hide(testView)
        XCTAssertEqual(testView.frame, CGRectMake(-100, 5, 100, 100))
    }
}
