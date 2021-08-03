//
//  JJCSegmentView.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/2.
//

import UIKit

public class JJCSegmentView: UIView {
    
    /// Int - 最大 title 个数
    private let maxNum: Int = 5
    /// UIColor - 选中按钮底部横条 颜色
    private var selectedBottomViewColor = UIColor.clear
    /// CGFloat - 选中按钮底部横条 X
    private var selectedBottomViewX: CGFloat = 0
    /// CGFloat - 选中按钮底部横条 宽度
    private var selectedBottomViewW: CGFloat = 0
    /// CGFloat - 选中按钮底部横条 高度
    private var selectedBottomViewH: CGFloat = 0
    /// UIColor - normal 文字颜色
    private var titleColor: UIColor = .black
    /// UIFont - normal 文字大小
    private var titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    /// UIColor - selected 文字颜色
    private var selectedTitleColor: UIColor = .black
    /// UIFont - selected 文字大小
    private var selectedTitleFont: UIFont = UIFont.systemFont(ofSize: 16)
    /// Array - 文字标题数组
    private var titles = [String]()
    
    /// UIScrollView - 按钮底部背景 ScrollView
    private var scrollView = UIScrollView()
    /// UIView - 选中按钮底部背景 View
    private lazy var selectedBgView = UIView()
    /// UIView - 选中按钮底部横条 View
    private lazy var selectedBottomView = UIView()
    /// UIButton - 上次选中的按钮
    private var lastSelectedBtn = UIButton(type: .custom)
    
    /// 按钮点击事件回调
    typealias ButtonActionBlock = (Int) -> Void
    var buttonActionBlock: ButtonActionBlock?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK:- UI
extension JJCSegmentView {
    
    /// UI
    private func setUI() {
        
        // UIView - 选中按钮底部横条 View
        self.selectedBottomView.frame = CGRect(x: 0, y: self.frame.size.height, width: 0, height: 0)
        addSubview(self.selectedBottomView)
    }
}

// MARK:- Methods
extension JJCSegmentView {
    
    /// Action - 核心方法
    public func setTitles(_ titles: [String], titleColor: UIColor, titleFont: UIFont, selectedTitleColor: UIColor, selectedTitleFont: UIFont) {
        
        // 缓存原始数据
        self.titles = titles
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.selectedTitleColor = selectedTitleColor
        self.selectedTitleFont = selectedTitleFont
        
        // 移除所有子视图
        _ = self.scrollView.subviews.map { $0.removeFromSuperview() }
        setSelectedBottomViewParams(color: self.selectedBottomViewColor, width: self.selectedBottomViewW, height: self.selectedBottomViewH)
        
        // UIScrollView - 按钮底部背景 ScrollView
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height - self.selectedBottomView.frame.size.height)
        self.scrollView.showsHorizontalScrollIndicator = false
        addSubview(self.scrollView)
        
        // 添加按钮
        var btnMaxWidth: CGFloat = 0
        for (index, title) in titles.enumerated() {
            
            var titleW = title.jjc_getContentSize(font: titleFont, contentMaxWH: titleFont.pointSize, isCalculateHeight: false).width + JJC_Margin * 2
            if self.frame.size.width > titleW * CGFloat(titles.count) {
                titleW = self.frame.size.width / CGFloat(titles.count)
            }
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: btnMaxWidth, y: 0, width: titleW, height: self.scrollView.frame.size.height)
            btn .setTitle(title, for: .normal)
            btn.setTitleColor(titleColor, for: .normal)
            btn.setTitleColor(selectedTitleColor, for: .selected)
            btn.titleLabel?.font = titleFont
            btn.tag = index
            btn.addTarget(self, action: #selector(btnAction(button:)), for: .touchUpInside)
            self.scrollView.addSubview(btn)
            
            if index == 0 {
                self.selectedBottomViewW = title.jjc_getContentSize(font: titleFont, contentMaxWH: titleFont.pointSize, isCalculateHeight: false).width
                self.selectedBottomViewX = (titleW - self.selectedBottomViewW) * 0.5
                self.selectedBottomView.frame = CGRect(x: self.selectedBottomViewX, y: self.selectedBottomView.frame.origin.y, width: self.selectedBottomViewW, height: self.selectedBottomView.frame.size.height)
                
                btn.isSelected = true
                btn.titleLabel?.font = selectedTitleFont
                self.lastSelectedBtn = btn
            }
            btnMaxWidth = btnMaxWidth + titleW
        }
    }
    
    /// Action - 选中按钮底部横条 View
    func setSelectedBottomViewParams(color: UIColor, width: CGFloat, height: CGFloat) {
        
        self.selectedBottomViewColor = color
        self.selectedBottomViewW = self.selectedBottomViewW == 0 ? width : selectedBottomViewW
        self.selectedBottomViewH = height
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height - self.selectedBottomViewH)
        self.selectedBottomView.frame = CGRect(x: self.selectedBottomViewX, y: self.frame.size.height - self.selectedBottomViewH, width: self.selectedBottomViewW, height: self.selectedBottomViewH)
        self.selectedBottomView.backgroundColor = color
    }
    
    /// Action - 更新标题
    func updateTitles(_ titles: [String]) {
        
        for object in self.scrollView.subviews {
            if object is UIButton {
                let button: UIButton = object as! UIButton
                button.setTitle(titles[button.tag], for: .normal)
            }
        }
    }
    
    /// Action - 按钮点击事件
    @objc private func btnAction(button: UIButton) {
        
        if self.lastSelectedBtn.tag == button.tag {
            
        } else {
            
            self.lastSelectedBtn.isSelected = false
            self.lastSelectedBtn.setTitleColor(self.titleColor, for: .normal)
            self.lastSelectedBtn.titleLabel?.font = self.titleFont
            button.isSelected = true
            button.setTitleColor(self.selectedTitleColor, for: .selected)
            button.titleLabel?.font = self.selectedTitleFont
            
            self.selectedBottomViewW = self.titles[button.tag].jjc_getContentSize(font: titleFont, contentMaxWH: titleFont.pointSize, isCalculateHeight: false).width
            self.selectedBottomViewX = button.frame.origin.x + (button.frame.size.width - self.selectedBottomViewW) * 0.5
            
            UIView.animate(withDuration: 0.3) {
                self.selectedBottomView.frame = CGRect(x: self.selectedBottomViewX, y: self.selectedBottomView.frame.origin.y, width: self.selectedBottomViewW, height: self.selectedBottomView.frame.size.height)
            }
            
            self.lastSelectedBtn = button
        }
        
        if let buttonActionBlock = self.buttonActionBlock {
            buttonActionBlock(self.lastSelectedBtn.tag)
        }
    }
}
