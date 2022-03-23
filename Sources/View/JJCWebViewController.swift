//
//  JJCWebViewController.swift
//  JJCSwiftTools
//
//  Created by mxgx on 2021/8/3.
//

import UIKit
import WebKit

public class JJCWebViewController: UIViewController {
    
    /// ObserveKey - estimatedProgress - 进度
    private let WebViewProgressObserveKey: String = "estimatedProgress"
    /// ObserveKey - URL - 链接
    private let WebViewURLObserveKey: String = "URL"
    /// ObserveKey - title - 标题
    private let WebViewTitleObserveKey: String = "title"
    /// ObserveKey - canGoBack - 是否可以返回
    private let WebViewGoBackObserveKey: String = "canGoBack"
    
    /// WKWebView
    public var webView: WKWebView = {
        let webV = WKWebView()
        webV.frame = CGRect(x: 0, y: JJC_StatusNaviH(), width: JJC_ScreenW, height: JJC_ScreenH - JJC_StatusNaviH())
        webV.allowsBackForwardNavigationGestures = true
        return webV
    }()
    /// UIProgressView - 进度条
    public var progressV: UIProgressView = {
        let progressV = UIProgressView()
        progressV.frame = CGRect(x: 0, y: JJC_StatusNaviH(), width: JJC_ScreenW, height: 2)
        progressV.trackTintColor = .clear
        progressV.progressTintColor = .orange
        return progressV
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: WebViewProgressObserveKey)
        self.webView.removeObserver(self, forKeyPath: WebViewURLObserveKey)
        self.webView.removeObserver(self, forKeyPath: WebViewTitleObserveKey)
        self.webView.removeObserver(self, forKeyPath: WebViewGoBackObserveKey)
    }
}

// MARK:- UI
extension JJCWebViewController {
    
    /// UI
    private func setUI() {
        
        // WKWebView
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        view.addSubview(self.webView)
        
        // 添加观察者
        self.webView.addObserver(self, forKeyPath: WebViewProgressObserveKey, options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: WebViewURLObserveKey, options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: WebViewTitleObserveKey, options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: WebViewGoBackObserveKey, options: .new, context: nil)
        
        // UIProgressView - 进度条
        view.insertSubview(self.progressV, aboveSubview: self.webView)
    }
}

// MARK:- Methods
extension JJCWebViewController {
    
    /// Action - 设置导航栏
    public func setNavigationParameters(bgColor: UIColor, title: String) {
        self.navigationController?.navigationBar.backgroundColor = bgColor
    }
    
    /// Action - 加载 url
    public func loadRequestUrl(_ urlString: String) {
        if let url = URL(string: urlString) {
            self.webView.load(URLRequest(url: url))
        }
    }
    
    /// Action - 观察者
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        switch keyPath {
        case WebViewProgressObserveKey:
            // 进度条
            self.progressV.progress = Float(self.webView.estimatedProgress)
            if self.webView.estimatedProgress >= 1.0 {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.progressV.progress = 0
                }
            }
        case WebViewURLObserveKey:
            // 链接
            break
        case WebViewTitleObserveKey:
            // 标题
            break
        case WebViewGoBackObserveKey:
            // 是否可以返回
            break
        default: super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

// MARK:- WKNavigationDelegate、WKUIDelegate
extension JJCWebViewController: WKNavigationDelegate, WKUIDelegate {
    
    /// Delegate - 加载完成
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Delegate - 加载完成")
    }
    
    /// Delegate - 页面加载失败
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Delegate - 页面加载失败")
        self.progressV.setProgress(0, animated: false)
    }
    
    /// Delegate - 提交发生错误
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Delegate - 提交发生错误")
        self.progressV.setProgress(0, animated: false)
    }
}
