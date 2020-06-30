//
//  Logger.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 日志记录器
@objc
public protocol DPLogger {
    
    /// 日志等级，如果输出的日志等级低于此等级，则记录器不回记录相关日志
    var logLevel: DPLogLevel { get }
    
    /// 格式处理器
    var formatter: DPLogFormatter { get }
    
    /// 处理日志输出
    /// - Parameter message: 日志信息
    func log(message: String)
}
