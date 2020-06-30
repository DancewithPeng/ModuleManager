//
//  Level.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 日志输出等级
@objc
public enum DPLogLevel: Int {
    /// 详细，如果Logger设置了此等级，则全部等级的日志信息都可见
    case verbose    = 0
    /// 调试，如果Logger设置了此等级，则debug等级以上的日志信息都可见
    case debug      = 1
    /// 信息，如果Logger设置了此等级，则info等级以上的日志信息都可见
    case info       = 2
    /// 警告，如果Logger设置了此等级，则warning等级以上的日志信息都可见
    case warning    = 3
    /// 错误，如果Logger设置了此等级，则error等级以上的日志信息都可见
    case error      = 4
    /// 不显示日志
    case none       = 999
}
