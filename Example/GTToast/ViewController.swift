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
    fileprivate let animations = ["Alpha", "Scale", "Bottom Slide In", "Left Slide In", "Right Slide In", "Left to Right", "Right to Left"]
    fileprivate var toast: GTToastView!
    
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
        
        updateImageAlignmentDisplayed(GTToastAlignment.left)
    }

    @IBAction func showToast(_ sender: AnyObject) {
        let selectedAnimation = animationPicker.selectedRow(inComponent: 0)
        
        let config = GTToastConfig(
            textAlignment: NSTextAlignment(rawValue: textAlignment.selectedSegmentIndex)!,
            animation: GTToastAnimation(rawValue: selectedAnimation)!.animations(),
            displayInterval: 4,
            imageMargins: selectedMargins(),
            imageAlignment: GTToastAlignment(rawValue: imageAlignment.selectedSegmentIndex)!
        )
        
        let image: UIImage? = showImageSwitch.isOn ? UIImage(named: "tick") : .none
        
        toast = GTToast.create("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eleifend maximus malesuada. Quisque congue augue vel mauris molestie, nec egestas eros ultrices.",
            config: config,
            image: image)
        toast.show()
    }
    
    @IBAction func hideToast(_ sender: AnyObject) {
        if let toast = toast , toast.displayed {
            toast.dismiss()
        }
    }
    
    fileprivate func selectedMargins() -> UIEdgeInsets {
        return UIEdgeInsets(
            top: textFieldValueToCGFloat(imgMarginTop),
            left: textFieldValueToCGFloat(imgMarginLeft),
            bottom: textFieldValueToCGFloat(imgMarginBottom),
            right: textFieldValueToCGFloat(imgMarginRight))
    }
    
    fileprivate func textFieldValueToCGFloat(_ textField: UITextField) -> CGFloat {
        guard let value = textField.text,  let number = NumberFormatter().number(from: value) else {
            return 0
        }
        
        return CGFloat(number)
    }
    
    @IBAction func imageAlignmentSelected(_ sender: AnyObject) {
        updateImageAlignmentDisplayed(GTToastAlignment(rawValue: imageAlignment.selectedSegmentIndex)!)
    }
    
    @IBAction func switchDefaultImageMargins(_ sender: AnyObject) {
        let control = sender as! UISwitch
        
        enableImageMarginTextFields(!control.isOn)
        
        updateImageAlignmentDisplayed(GTToastAlignment(rawValue: imageAlignment.selectedSegmentIndex)!)
    }
    
    fileprivate func enableImageMarginTextFields(_ enabled: Bool) {
        imgMarginTop.isEnabled = enabled
        imgMarginLeft.isEnabled = enabled
        imgMarginBottom.isEnabled = enabled
        imgMarginRight.isEnabled = enabled
    }
    
    fileprivate func updateImageAlignmentDisplayed(_ alignment: GTToastAlignment) {
        let insets = alignment.defaultInsets()
        
        imgMarginTop.text = String(describing: insets.top)
        imgMarginLeft.text = String(describing: insets.left)
        imgMarginBottom.text = String(describing: insets.bottom)
        imgMarginRight.text = String(describing: insets.right)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animations[row]
    }
}

