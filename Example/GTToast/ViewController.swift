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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func showToast(sender: AnyObject) {
        let selectedAnimation = animationPicker.selectedRowInComponent(0)
        
        let config = GTToastConfig(animation: GTToastAnimation(rawValue: selectedAnimation)!)
        GTToast.create("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eleifend maximus malesuada. Quisque congue augue vel mauris molestie, nec egestas eros ultrices. Aenean id purus dictum, luctus erat id, suscipit augue. Sed a sollicitudin eros. Donec id felis nec turpis convallis blandit sit amet vitae eros. Morbi et laoreet felis, id pulvinar augue. Suspendisse non nulla id est aliquet ultricies. Fusce bibendum blandit arcu, vel bibendum ipsum vestibulum vitae",
            config: config)
        .show()
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

