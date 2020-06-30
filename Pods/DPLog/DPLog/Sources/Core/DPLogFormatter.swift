//
//  Formatter.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 日志格式控制器
@objc
public protocol DPLogFormatter {
    
    /// 根据提供的信息返回对应的格式字符串
    /// - Parameter info: 提供的信息
    func formatString(for info: DPLogInformation) -> String
}
