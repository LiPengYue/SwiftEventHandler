//
//  CViewController.swift
//  SwiftSendEventTool
//
//  Created by 衣二三 on 2019/1/17.
//  Copyright © 2019年 衣二三. All rights reserved.
//

import UIKit

class CView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        setupViews()
        setupShadow()
    }
    let button = UIButton()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShadow() {
        layer.cornerRadius = 6
        layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        layer.borderWidth = 1
        layer.shadowColor = UIColor.init(white: 0, alpha: 0.3).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.init(width: 4, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
    }
    private func setupViews() {
        button.setTitle("点击CView:换背景色", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        addSubview(button)
 }
    @objc private func clickButton() {
        let color: UIColor!
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
       let str =  self.py_send(signalKey: ViewController.k_cview_clickButtonEventKey, message: color)
        print(str ?? "🌶 没有任何返回")
    }
}

