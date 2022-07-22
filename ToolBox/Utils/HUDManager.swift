//
//  HUDManager.swift
//  ToolBox
//
//  Created by Murph on 2022/7/22.
//

import UIKit
import SVProgressHUD

class HUDManager {
    static func setup() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaximumDismissTimeInterval(2)
    }
    
    static func showInfo(_ info: String) {
        SVProgressHUD.showInfo(withStatus: info)
    }
    
    static func showError(_ error: String) {
        SVProgressHUD.showError(withStatus: error)
    }
}
