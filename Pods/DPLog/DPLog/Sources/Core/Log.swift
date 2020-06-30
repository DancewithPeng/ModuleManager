//
//  Log.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// DPLog的主要接口
public final class Log {
    
    /// 初始化配置
    ///
    /// 这里可以指定日志的Logger，DPLog内置了一个ConsoleLogger，默认情况下会使用此Logger
    /// 用户可以自定义Logger，然后通过此方法来指定自定义的Logger，建议此setup方法在AppDelegate的application(_:,didFinishLaunchingWithOptions:)中调用
    /// - Parameter loggers: 指定的日志收集仪
    public class func setup(loggers: [DPLogger]) {
        DPLogCoordinator.shared.setup(loggers: loggers)
    }
    
    /// 输出error级别的日志
    /// - Parameters:
    ///   - message: 输出的信息
    public class func error(_ message: Any?, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
        
        let info = DPLogInformation(message: message,
                                    level: .error,
                                    file: file,
                                    line: line,
                                    function: function,
                                    date: date,
                                    process: process,
                                    thread: thread,
                                    threadID: threadID)
        
        DPLogCoordinator.shared.log(information: info)
    }
    
    /// 输出warning级别的日志
    /// - Parameters:
    ///   - message: 输出的信息
    public class func warning(_ message: Any?, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
        
        let info = DPLogInformation(message: message,
                                    level: .warning,
                                    file: file,
                                    line: line,
                                    function: function,
                                    date: date,
                                    process: process,
                                    thread: thread,
                                    threadID: threadID)
        
        DPLogCoordinator.shared.log(information: info)
    }
    
    /// 输出info级别的日志
    /// - Parameters:
    ///   - message: 输出的信息
    public class func info(_ message: Any?, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
        
        let info = DPLogInformation(message: message,
                                    level: .info,
                                    file: file,
                                    line: line,
                                    function: function,
                                    date: date,
                                    process: process,
                                    thread: thread,
                                    threadID: threadID)
        
        DPLogCoordinator.shared.log(information: info)
    }
    
    /// 输出debug级别的日志
    /// - Parameters:
    ///   - message: 输出的信息
    public class func debug(_ message: Any?, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
        
        let info = DPLogInformation(message: message,
                                    level: .debug,
                                    file: file,
                                    line: line,
                                    function: function,
                                    date: date,
                                    process: process,
                                    thread: thread,
                                    threadID: threadID)
        
        DPLogCoordinator.shared.log(information: info)
    }
}
