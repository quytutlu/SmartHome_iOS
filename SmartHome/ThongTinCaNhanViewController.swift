//
//  ThongTinCaNhanViewController.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 10/4/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import UIKit

class ThongTinCaNhanViewController: UIViewController {

    var ThamSoTruyen:NSUserDefaults!
    @IBOutlet weak var ttcn: UITextView!
    @IBOutlet weak var Open: UIBarButtonItem!
    var idNguoiDung:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        Open.target=self.revealViewController()
        Open.action=Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        ThamSoTruyen = NSUserDefaults()
        //idNguoiDung=ThamSoTruyen.valueForKey("idNguoiDung") as! String
        //print(idNguoiDung)
        let url="http://smarthometl.com/index.php/?cmd=laythongtinnguoidung&id=5";     LayThongTinCaNhan(url)
    }
    func LayThongTinCaNhan(urlString:String){
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                if(json==nil){
                    return
                }
                var tt="Mã tài khoản: "+json["id"].stringValue
                tt+="\nTên đăng nhập: "+json["TenDangNhap"].stringValue
                tt+="\nEmail: "+json["Email"].stringValue
                tt+="\nSố điện thoại: "+json["SDT"].stringValue
                tt+="\nNgười tạo: "+json["NguoiTao"].stringValue
                tt+="\nVai trò: "+json["VaiTro"].stringValue
                tt+="\nNgày tham gia: "+json["NgayThamGia"].stringValue
                ttcn.text=tt
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
