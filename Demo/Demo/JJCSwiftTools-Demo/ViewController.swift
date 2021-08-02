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
        print(UIColor(hexString: "#05C1AE").jjc_hexString ?? "")
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//        btn.jjc_params(image: UIImage(named: "001.jpg"), selectImage: nil, highlightImage: nil)
//        btn.jjc_params(image: UIImage(named: "001.jpg"), highlightImage: UIImage(named: "002.jepg"))
//        btn.jjc_params(title: "ssss", titleColor: .red, font: .systemFont(ofSize: 16), state: .normal)
//        btn.jjc_params(title: "测试", titleColor: .orange, font: , state: .highlighted)
//        btn.jjc_params(title: "测试", titleColor: .orange, fontSize: 20, state: .highlighted)
//        btn.jjc_params(title: "测试", titleColor: .orange, fontSize: 18, fontFamily: nil)
        btn.jjc_params(title: "测试", titleColor: .orange, fontFamily: nil, fontSize: 20, state: .highlighted, verticalAlignment: .top)
        view.addSubview(btn)
        
        
        // 测试 UISearchBar
        let searchBar = UISearchBar(frame: CGRect(x: 100, y: 250, width: 150, height: 50))
        searchBar.jjc_textField(bgColor: .orange)
        searchBar.jjc_textField(radius: 10, borderWidth: 1, borderColor: .black)
        searchBar.jjc_removeBlackLine()
        view.addSubview(searchBar)
        
        
        // 测试 UILabel
        let label = UILabel(frame: CGRect(x: 100, y: 350, width: 100, height: 50))
        label.backgroundColor = .lightGray
        label.jjc_params(text: "测试", textColor: .orange, fontSize: 20, weight: .bold, aligment: .center)
        view.addSubview(label)
        
        print(label.text!.jjc_isEmptyOrInvalid())
        
        label.text = "https://m.baidu.com/chapter/12345/tag/index.html"
        print(label.text!.jjc_removeLastURLParam())
        print(label.text!.jjc_getContentSize(fontSize: 15, contentMaxWH: 200))
        
        label.text = "八月"
        print(label.text!.jjc_toMonth().enAll)
        print(label.text!.jjc_toPinYin(isTone: true, isDealü: false))
        
        
        JJC_RadiusBorder(label, radius: 20, borderWidth: 5, borderColor: .black)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let alertVC = JJC_Alert(message: "测试一下", rightTitle: "", rightAction: {
            print("啊哈哈哈哈哈哈哈哈哈哈哈哈")
        })
        present(alertVC, animated: true, completion: nil)
    }
}




