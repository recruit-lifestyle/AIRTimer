//
//  ViewController.swift
//  Example
//
//  Created by Yuki Nagai on 9/25/15.
//  Copyright © 2015 Yuki Nagai. All rights reserved.
//

import UIKit
import AIRTimer

class ViewController: UIViewController {
    var timer: AIRTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = AIRTimer.every(3, userInfo: "FIRE!!!") { timer in
            // should be same pointer
            print(timer.userInfo!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func restart(sender: UIButton) {
        timer = timer?.restart()
        print("RESTART!!!")
    }

    @IBAction func stop(sender: UIButton) {
        timer?.invalidate()
        print("STOP!!!")
    }
}

