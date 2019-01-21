//
//  BViewController.swift
//  SwiftSendEventTool
//
//  Created by 衣二三 on 2019/1/17.
//  Copyright © 2019年 衣二三. All rights reserved.
//

import UIKit

class BView: UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 0.8357204861, alpha: 1)
        setupShadow()
        setupViews()
    }
    
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
    
    private func setupViews() {
        addGestureRecognizer(tap)
        addSubview(label)
        addSubview(cView)
        /// 给cView的block赋值为调用self的block
        NSObject.py_stitchChannelFunc(sender: cView, relay: self)
    }
    
    private lazy var cView: CView = {
        let view = CView()
        view.frame = CGRect.init(x: 10, y: 100, width: 100, height: 200)
        return view;
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "我是BView"
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        label.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        return label;
    }()
    private lazy var tap: UITapGestureRecognizer = {
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickB))
        return tap
    }()
    @objc private func clickB() {
        self.py_send(signalKey: ViewController.k_clickBviewEvent, message: "我是bView")
    }
}
