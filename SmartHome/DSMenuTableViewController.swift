//
//  DSMenuTableViewController.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 10/3/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import UIKit

class DSMenuTableViewController: UITableViewController {
    var Menu:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        Menu=["Cập nhật trạng thái","Thông tin cá nhân","Giới thiệu","Đăng xuất"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Menu.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Menu[indexPath.row], forIndexPath: indexPath)
        cell.textLabel?.text=Menu[indexPath.row]
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexSelected=self.tableView.indexPathForCell(sender as! UITableViewCell)
        let ChiSo:Int=indexSelected!.row
        print(String(ChiSo))
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row==3){
            if let resultController =
                storyboard!.instantiateViewControllerWithIdentifier("MHDangNhap") as? ViewController {
                    presentViewController(resultController, animated: false, completion: nil)
            }
        }
    }
}
