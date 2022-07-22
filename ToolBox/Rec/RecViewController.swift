//
//  RecViewController.swift
//  ToolBox
//
//  Created by Murph on 2022/7/22.
//

import UIKit
import Vision
import WebKit
import SnapKit

class RecViewController: UIViewController {
    @IBOutlet private weak var urlField: UITextField!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var resultTextView: UITextView!
    @IBOutlet private weak var resultTextContainer: UIView!
    
    private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
        checkIfUrlIsInClipBoard()
    }
    
    private func setupContent() {
        let webView = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration())
        self.contentView.addSubview(webView)
        self.webView = webView
        self.webView.snp.makeConstraints { [weak self] make in
            guard let strongSelf = self else { return }
            make.left.right.top.bottom.equalTo(strongSelf.contentView)
        }
        
        urlField.placeholder = "请输入网址"
        urlField.autocorrectionType = .no
        
        resultTextContainer.isHidden = true
        resultTextView.text = ""
        resultTextView.isEditable = false
    }
    
    private func checkIfUrlIsInClipBoard() {
        let pasteBoardStr = UIPasteboard.general.string ?? ""
        if RegUtil.isUrl(pasteBoardStr) {
            HUDManager.showInfo("已获取剪贴板复制的url 正在打开")
            urlField.text = pasteBoardStr
            loadUrl()
        }
    }
    
    private func loadUrl() {
        guard let url = URL(string: urlField.text ?? "") else { return }
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func editEnd(_ sender: Any) {
        loadUrl()
    }
    @IBAction func loadUrl(_ sender: Any) {
        loadUrl()
    }
    
    @IBAction func ocrInWebView(_ sender: Any) {
        resultTextContainer.isHidden = false
        UIGraphicsBeginImageContextWithOptions(self.contentView.frame.size, false, UIScreen.main.scale)
        self.webView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = image?.cgImage else { return }
        let req = VNRecognizeTextRequest { [weak self] res, err in
            guard err == nil, let strongSelf = self, let textObs = res.results else {
                HUDManager.showError("识别失败")
                return
            }
            var result = ""
            for obs in textObs {
                guard let text = (obs as? VNRecognizedTextObservation)?.topCandidates(1).first?.string else { continue }
                result.append("\n\(text)")
            }
            strongSelf.resultTextView.text = "\(strongSelf.resultTextView.text ?? "")\(result)"
        }
        HUDManager.showInfo("识别成功")
        req.recognitionLanguages = ["zh-Hans", "en-US"]
        let handler = VNImageRequestHandler(cgImage: image)
        try? handler.perform([req])
    }
    
    @IBAction func getResult(_ sender: Any) {
        guard resultTextView.text.count > 0 else {
            return
        }
        UIPasteboard.general.string = resultTextView.text
        HUDManager.showInfo("已复制到剪贴板")
    }
    
    @IBAction func clearResult(_ sender: Any) {
        resultTextView.text = ""
        resultTextContainer.isHidden = true
    }
}
