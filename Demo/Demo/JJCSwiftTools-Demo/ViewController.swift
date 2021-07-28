//
//  ViewController.swift
//  JJCSwiftTools-Demo
//
//  Created by mxgx on 2021/7/27.
//

import UIKit
import JJCSwiftTools

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .gray
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//        btn.jjc_params(image: UIImage(named: "001.jpg"), selectImage: nil, highlightImage: nil)
//        btn.jjc_params(title: "ssss", titleColor: .red, font: .systemFont(ofSize: 16), state: .normal)
        btn.jjc_params(title: "测试", titleColor: .orange, fontSize: 15, weight: .medium, state: .highlighted)
        view.addSubview(btn)
    }
}

