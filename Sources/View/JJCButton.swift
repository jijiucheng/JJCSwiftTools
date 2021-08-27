//
//  JJCButton.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/2.
//

import UIKit

public class JJCButton: UIControl {
    
    /// UIImage - normal
    private var imageNormal: UIImage?
    /// UIImage - selected
    private var imageSelected: UIImage?
    /// NSString - normal
    private var titleNormal: String?
    /// NSString - selected
    private var titleSelected: String?
    /// UIColor - normal
    private var colorNormal: UIColor?
    /// UIColor - selected
    private var colorSelected: UIColor?
    /// UIFont - normal
    private var fontNormal: UIFont?
    /// UIFont - selected
    private var fontSelected: UIFont?
    /// NSTextAlignment - normal
    private var alignmentNormal: NSTextAlignment?
    /// NSTextAlignment - selected
    private var alignmentSelected: NSTextAlignment?
    
    
    /// UIImageView - 图片
    private var imageView = UIImageView()
    /// UILabel - 文字
    private var titleLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

/// MARK:- Methods
extension JJCButton {
    
    /// Action - 核心方法
    public func params(style: UIButtonStyle,
                       image: UIImage?,
                       title: String?,
                       color: UIColor,
                       font: UIFont,
                       alignment: NSTextAlignment,
                       margin: CGFloat,
                       contentInsets: UIEdgeInsets) {
        
        self.imageNormal = image
        self.titleNormal = title
        self.colorNormal = color
        self.fontNormal = font
        self.alignmentNormal = alignment
        
        // UIImageView - 图片
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = image
        addSubview(self.imageView)
        
        // UILabel - 文字
        self.titleLabel.text = title
        self.titleLabel.textColor = color
        self.titleLabel.font = font
        self.titleLabel.textAlignment = alignment
        addSubview(self.titleLabel)
        
        self.isSelected = false
        
        let btnW: CGFloat = self.frame.size.width - (contentInsets.left + contentInsets.right)
        let btnH: CGFloat = self.frame.size.height - (contentInsets.top + contentInsets.bottom)
        let imageSize: CGSize = imageView.intrinsicContentSize
        
        var labelWidth: CGFloat = 0
        if style == .top || style == .bottom {
            labelWidth = btnW
        } else {
            labelWidth = self.titleLabel.intrinsicContentSize.width > (btnW - imageSize.width - margin) ? (btnW - imageSize.width - margin) : self.titleLabel.intrinsicContentSize.width
        }
        let labelSize: CGSize = CGSize(width: labelWidth, height: self.titleLabel.intrinsicContentSize.height)
        let horMargin: CGFloat = (btnW - imageSize.width - labelSize.width - margin) * 0.5
        let verMargin: CGFloat = (btnH - imageSize.height - labelSize.height - margin) * 0.5
        
        switch style {
        case .top:
            self.imageView.frame = CGRect(x: contentInsets.left + (btnW - imageSize.width) * 0.5,
                                          y: contentInsets.top + verMargin,
                                          width: imageSize.width,
                                          height: imageSize.height)
            self.titleLabel.frame = CGRect(x: contentInsets.left,
                                           y: self.imageView.frame.origin.y + imageSize.height + margin,
                                           width: btnW,
                                           height: labelSize.height)
        case .left:
            self.imageView.frame = CGRect(x: contentInsets.left + horMargin,
                                          y: contentInsets.top + (btnH - imageSize.height) * 0.5,
                                          width: imageSize.width,
                                          height: imageSize.height)
            self.titleLabel.frame = CGRect(x: contentInsets.left + horMargin + imageSize.width + margin,
                                           y: contentInsets.top + (btnH - labelSize.height) * 0.5,
                                           width: labelSize.width,
                                           height: labelSize.height)
        case .bottom:
            self.imageView.frame = CGRect(x: contentInsets.left + (btnW - imageSize.width) * 0.5,
                                          y: contentInsets.top + verMargin + labelSize.height + margin,
                                          width: imageSize.width,
                                          height: imageSize.height)
            self.titleLabel.frame = CGRect(x: contentInsets.left,
                                           y: contentInsets.top + verMargin,
                                           width: btnW,
                                           height: labelSize.height)
        case .right:
            self.imageView.frame = CGRect(x: self.frame.size.width - contentInsets.right - horMargin - imageSize.width,
                                          y: contentInsets.top + (btnH - imageSize.height) * 0.5,
                                          width: imageSize.width,
                                          height: imageSize.height)
            self.titleLabel.frame = CGRect(x: contentInsets.left + horMargin,
                                           y: contentInsets.top + (btnH - labelSize.height) * 0.5,
                                           width: labelSize.width,
                                           height: labelSize.height)
        }
    }
    
    /// Action - 核心方法（简版）
    public func params(style: UIButtonStyle,
                       image: UIImage? = nil,
                       title: String? = nil,
                       color: UIColor,
                       fontSize: CGFloat,
                       alignment: NSTextAlignment? = nil,
                       margin: CGFloat? = nil,
                       contentInsets: UIEdgeInsets? = nil) {
        
        var newAlignment: NSTextAlignment = alignment ?? .center
        if alignment == nil {
            switch style {
            case .top, .bottom:
                newAlignment = .center
            case .left:
                newAlignment = .left
            case .right:
                newAlignment = .right
            }
        }
        
        let newMargin: CGFloat = margin ?? JJC_Margin * 0.5
        let newContentInsets: UIEdgeInsets = contentInsets ?? .zero
    
        params(style: style, image: image, title: title, color: color, font: .systemFont(ofSize: fontSize), alignment: newAlignment, margin: newMargin, contentInsets: newContentInsets)
    }
}

// MARK:- 设置图片文字参数属性
extension JJCButton {
    
    /// Action - 设置图片文字参数属性
    public func params(image: UIImage, title: String, color: UIColor, font: UIFont, alignment: NSTextAlignment, state: UIControl.State) {
        
        if state == .selected {
            self.imageSelected = image
            self.titleSelected = title
            self.colorSelected = color
            self.fontSelected = font
            self.alignmentSelected = alignment
        } else {
            self.imageNormal = image
            self.titleNormal = title
            self.colorNormal = color
            self.fontNormal = font
            self.alignmentNormal = alignment
        }
        
        if state == .normal {
            self.isSelected = false
        }
    }
    
    /// Action - 设置图片文字参数属性 - 简版
    public func params(image: UIImage?, title: String?, color: UIColor?, font: UIFont?, state: UIControl.State) {
        let newImage = image ?? stateImage(state)
        let newTitle = title ?? stateText(state)
        let newColor = color ?? stateTextColor(state)
        let newFont = font ?? stateFont(state)
        let newAlignment = stateTextAlignment(state)
        params(image: newImage, title: newTitle, color: newColor, font: newFont, alignment: newAlignment, state: state)
    }
}

// MARK:- 根据 UIControl.State 状态获取当前属性
extension JJCButton {
    
    /// Parameters - image
    public func stateImage(_ state: UIControl.State) -> UIImage {
        return ((state == .selected ? self.imageSelected : self.imageNormal) ?? (self.imageView.image ?? UIImage()))
    }
    
    /// Parameters - title
    public func stateText(_ state: UIControl.State) -> String {
        return ((state == .selected ? self.titleSelected : self.titleNormal) ?? (self.titleLabel.text ?? ""))
    }
    
    /// Parameters - textColor
    public func stateTextColor(_ state: UIControl.State) -> UIColor {
        return (state == .selected ? self.colorSelected : self.colorNormal) ?? self.titleLabel.textColor
    }
    
    /// Parameters - font
    public func stateFont(_ state: UIControl.State) -> UIFont {
        return (state == .selected ? self.fontSelected : self.fontNormal) ?? self.titleLabel.font
    }
    
    /// Parameters - textAlignment
    public func stateTextAlignment(_ state: UIControl.State) -> NSTextAlignment {
        return (state == .selected ? self.alignmentSelected : self.alignmentNormal) ?? self.titleLabel.textAlignment
    }
}

// MARK:- 设置 UIControl.State
extension JJCButton {
    
    public override var isSelected: Bool {
        didSet {
            if isSelected == true {
                self.imageView.image = imageSelected
                self.titleLabel.text = titleSelected
                self.titleLabel.textColor = colorSelected
                self.titleLabel.font = fontSelected
                self.titleLabel.textAlignment = alignmentSelected ?? self.titleLabel.textAlignment
            } else {
                self.imageView.image = imageNormal
                self.titleLabel.text = titleNormal
                self.titleLabel.textColor = colorNormal
                self.titleLabel.font = fontNormal
                self.titleLabel.textAlignment = alignmentNormal ?? self.titleLabel.textAlignment
            }
        }
    }
}
