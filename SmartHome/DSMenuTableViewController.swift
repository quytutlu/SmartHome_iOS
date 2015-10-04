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
    var Anh:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        self.tableView.scrollEnabled=false
        Menu=["Cập nhật trạng thái","Thông tin cá nhân","Giới thiệu","Đăng xuất"]
        Anh=["ic_home.png","ic_photos.png","ic_people.png","ic_whats_hot.png"]
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
        //cell.textLabel?.text=Menu[indexPath.row]
        let hinh:UIImageView=UIImageView(frame: CGRectMake(10, 10, 30, 30))
        hinh.image=UIImage(named: Anh[indexPath.row])
        cell.addSubview(hinh)
        let ten:UILabel = UILabel(frame: CGRectMake(50, 5, 200, 40))
        ten.text=Menu[indexPath.row]
        cell.addSubview(ten)
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexSelected=self.tableView.indexPathForCell(sender as! UITableViewCell)
        let ChiSo:Int=indexSelected!.row
        print(String(ChiSo))
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row==3){
            let refreshAlert = UIAlertController(title: "Xác nhận", message: "Bạn có chắc chắn muốn đăng xuất?", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                if let resultController =
                    self.storyboard!.instantiateViewControllerWithIdentifier("MHDangNhap") as? ViewController {
                        self.presentViewController(resultController, animated: true, completion: nil)
                }
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Huỷ", style: .Default, handler: { (action: UIAlertAction!) in
                //println("Handle Cancel Logic here")
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
        }
    }
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        
        // Only allow Portrait
        return UIInterfaceOrientation.Portrait
    }
}
