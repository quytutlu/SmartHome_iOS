//
//  ViewController.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 9/30/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate
{

    @IBOutlet weak var TenDangNhap: UITextField!
    
    @IBOutlet weak var MatKhau: UITextField!
    var ThamSoTruyen:NSUserDefaults!
    
    @IBAction func DangNhap(sender: AnyObject) {
        let url="http://localhost/index.php/?cmd=dangnhap&tendangnhap="+TenDangNhap.text!+"&matkhau="+MatKhau.text!
        APIDangNhap(url)
    }
    override func viewDidLoad() {
        if(FBSDKAccessToken.currentAccessToken()==nil){
            print("Not logged in...")
            FBSDKAccessToken.setCurrentAccessToken(nil)
        }else{
            print("Logged in..")
            FBSDKAccessToken.setCurrentAccessToken(nil)
        }
        let loginButton=FBSDKLoginButton()
        loginButton.readPermissions=["public_profile","email","user_friends"]
        loginButton.delegate=self
        loginButton.center=self.view.center;
        self.view.addSubview(loginButton)
        
    }
    func APIDangNhapFb(postString:String){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/index.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            let responseString:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            let jsonData:NSData = responseString.dataUsingEncoding(NSUTF8StringEncoding)!
            let json = JSON(data:jsonData)
            print(json["active"].stringValue)
            if(json["active"]=="1"){
                self.ChuyenManHinh(json["id"].stringValue)
            }else{
                self.showMess()
            }
        }
        task.resume()
    }
    func ChuyenManHinh(id:String){
        ThamSoTruyen=NSUserDefaults()
        ThamSoTruyen.setObject(id, forKey: "idNguoiDung")
        if let resultController = storyboard!.instantiateViewControllerWithIdentifier("MHTrangThai") as? DsThietBiTableViewController {
                presentViewController(resultController, animated: true, completion: nil)
        }
        
    }
    func APIDangNhap(urlString:String){
        print(urlString)
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
        }else{
            showMess()
        }
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if(error==nil){
            let accessToken = FBSDKAccessToken.currentAccessToken()
            let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
            req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
                if(error == nil)
                {
                    //print("result \(result)")
                    let resultdict = result as? NSDictionary
                    let idvalue = resultdict?["id"] as! String
                    //print("the id value is \(idvalue)")
                    let emailvalue = resultdict?["email"] as! String
                    //print("the email value is \(emailvalue)")
                    let namevalue = resultdict?["name"] as! String
                    //print("the name value is \(namevalue)")
                    let json="{%22name%22:%22"+namevalue+"%22,%22id%22:%22"+idvalue+"%22}";
                    var url = "tendangnhapfb="+json+"&email="+emailvalue;
                    url=url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                    self.APIDangNhapFb(url)
                }
                else
                {
                    print("error \(error)")
                }
            })
            print("login complete..")
            FBSDKAccessToken.setCurrentAccessToken(nil)
            
        }else{
            print(error.localizedDescription)
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out...")
    }
    func showMess() {
        let ac = UIAlertController(title: "Thông báo", message: "Đăng nhập thất bại", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

