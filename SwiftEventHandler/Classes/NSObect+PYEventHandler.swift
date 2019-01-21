//
//  NSObectEventTransmit+Extension.swift
//  koalareading
//
//  Created by 李鹏跃 on 2017/11/3.
//  Copyright © 2017年 koalareading. All rights reserved.
//

import UIKit

private func py_log(_ item: Any) {
    #if DEBUG
    print(item)
    #endif
}


// MATK: - 每一个对象中都包含一个block，
/**
 1. block 一共两个 参数： 1. 用于区分data的key 2. 传递的具体数据
    还有一个返回值 为any，从而做到一些回调通信。
 2. 中心思想：
  a 持有b 、 b持有c。
 1.   c中block 的代码块为对b的代码块的调用。b的代码块在a中赋值。
 2.   这样调用c的block，就会调用b的block， b的block具体实现在a
 3.  返回值：c调用block的时候，相当于b的block调用。b的block要求返回一些数据、a可以根据情况进行返回数据，b的block在调用后的到了返回值，并且返回给了c。
 https://www.jianshu.com/p/a5d0ce71259f
 */

extension NSObject {
    /// block 定义了 两个参数 1. 区分数据的key； 2. 传递的数据
    public typealias EVENTCALLBACKBLOCK = (_ signalKey: String, _ messageObj: Any)->(Any)?
    
    /// 对 sender 的block进行赋值
    public func py_received(sendler Sendler: NSObject?,  eventCallBack: @escaping EVENTCALLBACKBLOCK) {
        self.py_received_private(sendler: Sendler, eventCallBack: eventCallBack)
    }
    
    /// 调用 self 的block
    @discardableResult
    public func py_send (signalKey SignalKey: String, message Message: Any) -> (Any)? {
        return self.py_send_private(signalKey: SignalKey, message: Message)
    }
    /// 传输通道
    ///
    /// - Parameters:
    ///   - Sender: 发送消息的对象
    ///   - Relay: 接收消息的对象
    /// - warning: 其实就是把sender的block赋值 为 对relay的block的调用
    public class func py_stitchChannelFunc(sender Sender: NSObject?, relay Relay: NSObject?) {
        self.py_stitchChannel_privateFunc(sender: Sender, relay: Relay)
    }
}

private extension NSObject {
    
    struct NSObectEventTransmitExtension {
        static let EVENTCALLBACKBLOCKKEY = UnsafeRawPointer.init(bitPattern:"EVENTCALLBACKBLOCKKEY".hashValue)
    }
    
    /// 对 sender 的block进行赋值
    func py_received_private(sendler Sendler: NSObject?,  eventCallBack: @escaping EVENTCALLBACKBLOCK) {
        if (Sendler == nil) {
            let str = "\n  🌶🌶🌶 接收数据的时候，sender 为 nil\n  方法：【py_received(sendler Sendler: NSObject?,  eventCallBack: @escaping EVENTCALLBACKBLOCK)】 \n\n"
            py_log(str)
            return;
        }
        objc_setAssociatedObject(Sendler!, NSObectEventTransmitExtension.EVENTCALLBACKBLOCKKEY!, eventCallBack, .OBJC_ASSOCIATION_COPY)
    }
    
    /// 调用 self 的block
    @discardableResult
    func py_send_private (signalKey SignalKey: String, message Message: Any) -> (Any)? {
        let eventBlock: EVENTCALLBACKBLOCK? = objc_getAssociatedObject(self, NSObectEventTransmitExtension.EVENTCALLBACKBLOCKKEY!) as? EVENTCALLBACKBLOCK
        #if DEBUG
        
        let vc = getTopVC()
        var topVcStr = "😝 无法获取。。"
        if let vc = vc {
            topVcStr = "\(type(of: vc))"
        }
        if (eventBlock == nil) {
            let str = "\n\n 🌶🌶🌶"
                + "\n 【\(type(of: self))】： 暂时没有 注册block"
                + "\n 【key】：\(SignalKey)"
                + "\n 【顶层VC】：\(topVcStr)\n 🌶🌶🌶\n\n"
            py_log(str)
            }else{
            let str = "\n  👌【key】： \(SignalKey)"
                + "\n  👌【sender】： \(type(of: self))"
                + "\n  👌【顶层VC】： \(topVcStr)"
            py_log(str)
        }
        #endif
        
        if (eventBlock == nil) {
            return nil;
        }
        return eventBlock!(SignalKey,Message) as (Any)?
    }
    
    /// 传输通道
    ///
    /// - Parameters:
    ///   - Sender: 发送消息的对象
    ///   - Relay: 接收消息的对象
    /// - warning: 其实就是把sender的block赋值 为 对relay的block的调用
    class func py_stitchChannel_privateFunc(sender Sender: NSObject?, relay Relay: NSObject?) {
        if Sender == nil || Relay == nil{
            py_log("🌶：sender或者receiver为nil")
            return
        }
        
        /// 给 【sendler对象】 的block 赋值为 Relay?.py_send(signalKey: signalKey, message: message)
        NSObject().py_received(sendler: Sender, eventCallBack: { [weak Relay] (signalKey, message) -> (Any)? in
            /// 调用了 relay 的 block
            return Relay?.py_send(signalKey: signalKey, message: message)
        })
    }
    
    
    private func py_stitchChannelFunc(sender Sender: NSObject?) {
        if Sender == nil {
            py_log("\n\n  🌶：【\(self)】：py_stitchChannelFunc 中 sender为nil \n")
            return
        }
        self.py_received(sendler: Sender) {[weak self] (signalKey, message) -> (Any)? in
            return self?.py_send(signalKey: signalKey, message: message)
        }
    }
}


 //MARK: - 查找顶层控制器、
/// 获取顶层控制器 根据window

private func getTopVC() -> (UIViewController?) {
    var window = UIApplication.shared.keyWindow
    //是否为当前显示的window
    if window?.windowLevel != UIWindowLevelNormal{
        let windows = UIApplication.shared.windows
        for  windowTemp in windows{
            if windowTemp.windowLevel == UIWindowLevelNormal{
                window = windowTemp
                break
            }
        }
    }
    
    let vc = window?.rootViewController
    return getTopVC(withCurrentVC: vc)
}

///根据控制器获取 顶层控制器
private func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
    
    if VC == nil {
        print("🌶： 找不到顶层控制器")
        return nil
    }
    
    if let presentVC = VC?.presentedViewController {
        //modal出来的 控制器
        return getTopVC(withCurrentVC: presentVC)
    }
    else if let tabVC = VC as? UITabBarController {
        // tabBar 的跟控制器
        if let selectVC = tabVC.selectedViewController {
            return getTopVC(withCurrentVC: selectVC)
        }
        return nil
    } else if let naiVC = VC as? UINavigationController {
        // 控制器是 nav
        return getTopVC(withCurrentVC:naiVC.visibleViewController)
    }
    else {
        // 返回顶控制器
        return VC
    }
}
