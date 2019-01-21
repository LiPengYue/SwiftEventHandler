//
//  ViewController.swift
//  SwiftEventHandler
//
//  Created by LiPengYue on 01/21/2019.
//  Copyright (c) 2019 LiPengYue. All rights reserved.
//

import UIKit
import SwiftEventHandler

let KSCRRENW = UIScreen.main.bounds.width
let KSCRRENH = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    /// cview点击button更换vc的view的背景色
    static let k_cview_clickButtonEventKey = "k_cview_clickButtonEventKey"
    static let k_clickBviewEvent = "k_clickBviewEvent"
    
    let bview = BView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        bview.frame = CGRect.init(x: 10, y: 10, width: KSCRRENW - 40, height: 400)
        view.addSubview(bview)
        //        return;
        self.registerBviewEvent()
    }
    
    private func registerBviewEvent() {
        
        self.py_received(sendler: bview) { [weak self](key, message) -> (Any)? in
            var result: Any? = nil
            
            ViewController.k_clickBviewEvent
                .py_EHConvertType(key: key, message: message, success: { (message:String) in
                    print(message)
                    result = nil
                })
            
            ViewController.k_cview_clickButtonEventKey
                .py_EHConvertType(key: key, message: message, success: { (color:UIColor) in
                    result = "✅：vc接收到了数据 并返回给了cView进行打印"
                    self?.view.backgroundColor = color
                }, failure: { (value) in
                    result = "🌶：cView发送的数据不是UIColor类型"
                })
            return result
        }
    }
}

