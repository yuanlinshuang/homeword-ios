//
//  ViewController.swift
//  transition
//
//  Created by apple on 2018/12/15.
//  Copyright © 2018年 yls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func tranclicked(_ sender: Any) {
        image.image = UIImage(named : "1")
        UIView.transition(from: myView, to: image, duration: 2, options: .transitionCurlUp, completion: nil)
    }
}

