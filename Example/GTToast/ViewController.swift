//
//  ViewController.swift
//  GTToast
//
//  Created by gregttn on 10/03/2015.
//  Copyright (c) 2015 gregttn. All rights reserved.
//

import UIKit
import GTToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        GTToast.create("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eleifend maximus malesuada. Quisque congue augue vel mauris molestie, nec egestas eros ultrices. Aenean id purus dictum, luctus erat id, suscipit augue. Sed a sollicitudin eros. Donec id felis nec turpis convallis blandit sit amet vitae eros. Morbi et laoreet felis, id pulvinar augue. Suspendisse non nulla id est aliquet ultricies. Fusce bibendum blandit arcu, vel bibendum ipsum vestibulum vitae").show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

