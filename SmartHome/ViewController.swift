//
//  ViewController.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 9/30/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TenDangNhap: UITextField!
    
    @IBOutlet weak var MatKhau: UITextField!
    var ThamSoTruyen:NSUserDefaults!
    
    @IBAction func DangNhap(sender: AnyObject) {
        let url="http://smarthometl.com/index.php/?cmd=dangnhap&tendangnhap="+TenDangNhap.text!+"&matkhau="+MatKhau.text!
        APIDangNhap(url)
    }
    func APIDangNhap(urlString:String){
        ThamSoTruyen=NSUserDefaults()
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                print(json["active"].stringValue)
                if(json["active"].stringValue=="1"){
                    ThamSoTruyen.setObject(String(json["id"].stringValue), forKey: "idNguoiDung")
                    if let resultController = storyboard!.instantiateViewControllerWithIdentifier("MHTrangThai") as? DsThietBiTableViewController {
                        presentViewController(resultController, animated: true, completion: nil)
                    }
                }else{
                    showMess()
                }
            }
        }
    }
    func showMess() {
        let ac = UIAlertController(title: "Thông báo", message: "Đăng nhập thất bại", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

