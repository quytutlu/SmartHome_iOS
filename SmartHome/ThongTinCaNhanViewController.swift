//
//  ThongTinCaNhanViewController.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 10/4/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import UIKit

class ThongTinCaNhanViewController: UIViewController {

    @IBOutlet weak var Open: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        Open.target=self.revealViewController()
        Open.action=Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
