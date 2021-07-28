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
        
        
        // 测试 UIButton
        let btn = UIButton(type: .custom)
//        btn.backgroundColor = .gray
        btn.backgroundColor = UIColor(hexString: "#05C1AE")
        print(UIColor(hexString: "#05C1AE").hexString ?? "")
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//        btn.jjc_params(image: UIImage(named: "001.jpg"), selectImage: nil, highlightImage: nil)
//        btn.jjc_params(image: UIImage(named: "001.jpg"), highlightImage: UIImage(named: "002.jepg"))
//        btn.jjc_params(title: "ssss", titleColor: .red, font: .systemFont(ofSize: 16), state: .normal)
//        btn.jjc_params(title: "测试", titleColor: .orange, font: , state: .highlighted)
//        btn.jjc_params(title: "测试", titleColor: .orange, fontSize: 20, state: .highlighted)
//        btn.jjc_params(title: "测试", titleColor: .orange, fontSize: 18, fontFamily: nil)
        btn.jjc_params(title: "测试", titleColor: .orange, fontSize: 20, fontFamily: nil, state: .highlighted, verticalAlignment: .top)
        view.addSubview(btn)
        
        
        // 测试 UISearchBar
        let searchBar = UISearchBar(frame: CGRect(x: 100, y: 250, width: 150, height: 50))
        searchBar.jjc_textField(bgColor: .orange)
        searchBar.jjc_textField(radius: 10, borderWidth: 1, borderColor: .black)
        view.addSubview(searchBar)
    }
}

