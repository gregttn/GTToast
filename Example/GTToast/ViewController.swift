//
//  ViewController.swift
//  GTToast
//
//  Created by gregttn on 10/03/2015.
//  Copyright (c) 2015 gregttn. All rights reserved.
//

import UIKit
import GTToast

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private let animations = ["Alpha", "Scale", "Bottom Slide In", "Left Slide In", "Right Slide In", "Left to Right", "Right to Left"]
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var animationPicker: UIPickerView!
    @IBOutlet weak var showImageSwitch: UISwitch!
    @IBOutlet weak var textAlignment: UISegmentedControl!
    @IBOutlet weak var imageAlignment: UISegmentedControl!
    @IBOutlet weak var imgMarginTop: UITextField!
    @IBOutlet weak var imgMarginLeft: UITextField!
    @IBOutlet weak var imgMarginBottom: UITextField!
    @IBOutlet weak var imgMarginRight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateImageAlignmentDisplayed(GTToastAlignment.Left)
    }

    @IBAction func showToast(sender: AnyObject) {
        let selectedAnimation = animationPicker.selectedRowInComponent(0)
        
        let config = GTToastConfig(
            animation: GTToastAnimation(rawValue: selectedAnimation)!,
            textAlignment: NSTextAlignment(rawValue: textAlignment.selectedSegmentIndex)!,
            imageAlignment: GTToastAlignment(rawValue: imageAlignment.selectedSegmentIndex)!,
            imageMargins: selectedMargins()
        )
        
        let image: UIImage? = showImageSwitch.on ? UIImage(named: "tick") : .None
        
        GTToast.create("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eleifend maximus malesuada. Quisque congue augue vel mauris molestie, nec egestas eros ultrices. Aenean id purus dictum, luctus erat id, suscipit augue. Sed a sollicitudin eros. Donec id felis nec turpis convallis blandit sit amet vitae eros. Morbi et laoreet felis, id pulvinar augue. Suspendisse non nulla id est aliquet ultricies. Fusce bibendum blandit arcu, vel bibendum ipsum vestibulum vitae",
            config: config,
            image: image)
        .show()
    }
    
    private func selectedMargins() -> UIEdgeInsets {
        return UIEdgeInsets(
            top: textFieldValueToCGFloat(imgMarginTop),
            left: textFieldValueToCGFloat(imgMarginLeft),
            bottom: textFieldValueToCGFloat(imgMarginBottom),
            right: textFieldValueToCGFloat(imgMarginRight))
    }
    
    private func textFieldValueToCGFloat(textField: UITextField) -> CGFloat {
        guard let value = textField.text,  let number = NSNumberFormatter().numberFromString(value) else {
            return 0
        }
        
        return CGFloat(number)
    }
    
    @IBAction func imageAlignmentSelected(sender: AnyObject) {
        updateImageAlignmentDisplayed(GTToastAlignment(rawValue: imageAlignment.selectedSegmentIndex)!)
    }
    
    @IBAction func switchDefaultImageMargins(sender: AnyObject) {
        let control = sender as! UISwitch
        
        enableImageMarginTextFields(!control.on)
        
        updateImageAlignmentDisplayed(GTToastAlignment(rawValue: imageAlignment.selectedSegmentIndex)!)
    }
    
    private func enableImageMarginTextFields(enabled: Bool) {
        imgMarginTop.enabled = enabled
        imgMarginLeft.enabled = enabled
        imgMarginBottom.enabled = enabled
        imgMarginRight.enabled = enabled
    }
    
    private func updateImageAlignmentDisplayed(alignment: GTToastAlignment) {
        let insets = alignment.defaultInsets()
        
        imgMarginTop.text = String(insets.top)
        imgMarginLeft.text = String(insets.left)
        imgMarginBottom.text = String(insets.bottom)
        imgMarginRight.text = String(insets.right)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animations.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animations[row]
    }
}

