//
//  ThietBi.swift
//  SmartHome
//
//  Created by NGUYEN QUY TU on 10/1/15.
//  Copyright © 2015 quytutlu. All rights reserved.
//

import Foundation
import UIKit
class ThietBi {
    var idThietBi:String
    var TenThietBi:String
    var TrangThai:String
    var ReadOnly:String
    init(){
        idThietBi=""
        TenThietBi="quytutlu"
        TrangThai=""
        ReadOnly=""
    }
    init(idThietBi:String,TenThietBi:String,TrangThai:String,ReadOnly:String){
        self.idThietBi=idThietBi
        self.TenThietBi=TenThietBi
        self.TrangThai=TrangThai
        self.ReadOnly=ReadOnly
    }
    func SetThuocTinh(idThietBi:String,TenThietBi:String,TrangThai:String,ReadOnly:String){
        self.idThietBi=idThietBi
        self.TenThietBi=TenThietBi
        self.TrangThai=TrangThai
        self.ReadOnly=ReadOnly
    }
    func Display(){
        print("TenThietBi: "+self.TenThietBi+"\n")
    }
}