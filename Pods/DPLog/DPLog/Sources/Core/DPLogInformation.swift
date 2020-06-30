//
//  Information.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 日志信息
@objc
public class DPLogInformation: NSObject {
    
    /// 用户输出的主要信息
    @objc
    public var message: Any?
    
    /// 日志等级
    @objc
    public var level: DPLogLevel
    
    /// 文件路径
    @objc
    public var file: String
    
    /// 输出日志的所在行
    @objc
    public var line: Int
    
    /// 函数名
    @objc
    public var function: String
    
    /// 日期
    @objc
    public var date: Date
    
    /// 进程信息
    @objc
    public var process: ProcessInfo
    
    /// 线程信息
    @objc
    public var thread: Thread
    
    /// 线程ID
    @objc
    public var threadID: UInt32
    
    @objc
    public init(message: Any?, level: DPLogLevel, file: String, line: Int, function: String, date: Date, process: ProcessInfo, thread: Thread, threadID: UInt32) {
        self.message  = message
        self.level    = level
        self.file     = file
        self.line     = line
        self.function = function
        self.date     = date
        self.process  = process
        self.thread   = thread
        self.threadID = threadID
    }
}
