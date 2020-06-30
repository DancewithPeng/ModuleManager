//
//  ConsoleLogger.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 控制台日志记录仪
@objc
public final class DPConsoleLogger: NSObject, DPLogger {
    
    /// 输出的队列
    let dispatchQueue: DispatchQueue
    
    /// 日志等级
    @objc
    public var logLevel: DPLogLevel
    
    /// 输出格式器
    @objc
    public var formatter: DPLogFormatter
    
    /// 初始化方法
    /// - Parameters:
    ///   - logLevel: 日志等级
    ///   - formatter: 输出个格式器
    @objc
    public init(logLevel: DPLogLevel = .debug, formatter: DPLogFormatter = DPLogDefaultFormatter()) {
        self.logLevel = logLevel
        self.formatter = formatter
        self.dispatchQueue = DispatchQueue(label: "DefaultFormatter.LogQueue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    }
    
    /// 输出日志处理
    /// - Parameter message: 日志信息
    public func log(message: String) {
        dispatchQueue.async {
            print(message)
        }
    }
}
