//
//  NSObject+PYType.swift
//  SwiftSendEventTool
//
//  Created by 衣二三 on 2019/1/17.
//  Copyright © 2019年 衣二三. All rights reserved.
//

import UIKit

private func py_log(_ item: Any) {
    #if DEBUG
    print(item)
    #endif
}
extension NSObject {
    /// 类型转换 返回原始数据
    @discardableResult
    class open func py_conversionType<T>(message: Any?, success: ((_ message: T)->())?, failure:((_ objc: Any?)->())? = nil) -> Any? {
        if let message = message as? T {
            return success?(message)
        }
        py_log("\n     🌶🌶🌶 类型转化出错 《\(type(of: message))》 "
            + "无法转化为"
            + " 《\(T.self)》 "
            + "类型\n"
            + "            \n🌶objc为：\n" + "\(String(describing: message))\n🌶")
        return failure?(message)
        
    }
}

public extension String {
    @discardableResult
    public func py_EHConvertType<T>(key Key:String?, message: Any?, success: ((_ message: T)->())?, failure:((_ objc: Any?)->())? = nil) -> Any? {
        if (self.isEqual(Key)) {
           return NSObject.py_conversionType(message: message, success: success, failure: failure)
        }else {
            py_log("\n 事件匹配失败【\(self) != \(Key ?? "")】")
            return nil
        }
    }
}
