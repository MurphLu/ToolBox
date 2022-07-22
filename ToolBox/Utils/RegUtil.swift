//
//  RegUtil.swift
//  ToolBox
//
//  Created by Murph on 2022/7/22.
//

import Foundation

class RegUtil {
    static func isUrl(_ string: String) -> Bool {
        guard let reg = try? NSRegularExpression(pattern: "^https?:\\/\\/(?:www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b(?:[-a-zA-Z0-9()@:%_\\+.~#?&\\/=]*)$") else {
            return false
        }
        if let url = reg.matches(in: string, range: NSMakeRange(0, string.count)).first {
            return url.range.location == 0 && url.range.length == string.count
        }
        return false
    }
}
