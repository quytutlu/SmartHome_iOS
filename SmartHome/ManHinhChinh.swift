//
//  ManHinhChinh.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 10/3/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import UIKit

class ManHinhChinh: UIViewController {
    @IBOutlet weak var Open: UIBarButtonItem!
    override func viewDidLoad() {
        Open.target=self.revealViewController()
        Open.action=Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}











