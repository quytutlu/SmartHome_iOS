//
//  DsThietBiTableViewController.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 9/30/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import UIKit

class DsThietBiTableViewController: UITableViewController {
    var ListThietBi:[ThietBi] = []
    var idThietBi:[String]=[]
    var dem:Int=0
    var ThamSoTruyen:NSUserDefaults!
    var idNguoiDung:String!
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.scrollsToTop=false
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        ThamSoTruyen=NSUserDefaults()
        idNguoiDung=ThamSoTruyen.valueForKey("idNguoiDung") as! String
        let urlString = "http://smarthometl.com/index.php?cmd=laytrangthai&id="+idNguoiDung
        LayDanhSachThietBi(urlString)
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Đang cập nhật...")
        refreshControl.addTarget(self, action: Selector("UploadStt"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        UploadStt()
    }
    func UploadStt() {
        if let resultController =
            storyboard!.instantiateViewControllerWithIdentifier("MHTrangThai") as? DsThietBiTableViewController {
                //refreshControl?.endRefreshing()
            presentViewController(resultController, animated: false, completion: nil)
        }
        //tableView.reloadData()
        //refreshControl?.endRefreshing()
    }
    func LayDanhSachThietBi(urlString:String){
        
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                if(json==nil){
                    showError()
                    return
                }
                for result in json["list"].arrayValue {
                    let idThietBi=result["id"].stringValue
                    let TenTB = result["TenThietBi"].stringValue
                    let TrangThai=result["TrangThai"].stringValue
                    let ReadOnly=result["ReadOnly"].stringValue
                    let temp=ThietBi()
                    temp.SetThuocTinh(idThietBi, TenThietBi: TenTB, TrangThai: TrangThai,ReadOnly:ReadOnly)
                    //print(TenTB)
                    ListThietBi.append(temp)
                }
            }
        }else{
            showError()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListThietBi.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let lbThietBi:UILabel=UILabel(frame: CGRectMake(20, 10, 300, 20))
        lbThietBi.text=ListThietBi[indexPath.row].TenThietBi
        cell.addSubview(lbThietBi)
        if(ListThietBi[indexPath.row].ReadOnly=="0"){
            let swTrangThai:UISwitch=UISwitch(frame: CGRectMake(650, 5, 50, 30))
            if(ListThietBi[indexPath.row].TrangThai=="1"){
                swTrangThai.on=true
            }
            idThietBi.append(ListThietBi[indexPath.row].idThietBi)
            swTrangThai.tag=dem
            dem++
            swTrangThai.addTarget(self, action: "BatTatThietBi:", forControlEvents: .ValueChanged)
            cell.addSubview(swTrangThai)
        }else{
            let lbTrangThai:UILabel=UILabel(frame: CGRectMake(650, 10, 50, 20))
            lbTrangThai.text=ListThietBi[indexPath.row].TrangThai
            cell.addSubview(lbTrangThai)
        }
        cell.selectionStyle=UITableViewCellSelectionStyle.None
        return cell
    }
    func BatTatThietBi(sender:UISwitch){
        print(idThietBi[sender.tag])
        if(sender.on==true){
            self.progressBarDisplayer("Đang bật "+ListThietBi[sender.tag].TenThietBi+"...",true)
            ChuyenTrangThaiThietBi("bat",idThietBi: idThietBi[sender.tag])
        }else{
            self.progressBarDisplayer("Đang tắt "+ListThietBi[sender.tag].TenThietBi+"...",true)
            ChuyenTrangThaiThietBi("tat",idThietBi: idThietBi[sender.tag])
        }
    }
    func ChuyenTrangThaiThietBi(TrangThai:String,idThietBi:String){
        let urlString = "http://smarthometl.com/index.php/?cmd="+TrangThai+"thietbi&id="+idNguoiDung+"&idthietbi="+idThietBi
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                print(json["success"].boolValue)
                self.messageFrame.removeFromSuperview()
            }
        }else{
            self.messageFrame.removeFromSuperview()
            showError()
        }
    }
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "Lỗi kết nối mạng", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 300, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 300, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.center=view.center
        //messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.9)
        messageFrame.backgroundColor=UIColor.blackColor()
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
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
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
