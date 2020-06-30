//
//  DefaultFormatter.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 默认格式处理器
@objc
public final class DPLogDefaultFormatter: NSObject, DPLogFormatter {
    
    /// 日期格式
    let dateFormatter: DateFormatter
    
    /// 初始化方法
    /// - Parameter dateFormat: 日期格式
    @objc
    public init(dateFormat: String = "yyyy-MM-dd HH:mm:ss.SSS") {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = dateFormat        
    }
    
    /// 返回对应的格式字符串
    /// - Parameter info: 信息
    /// - Returns: 返回格式化号的字符串
    public func formatString(for info: DPLogInformation) -> String {
        let dateString = dateFormatter.string(from: info.date)
        let processString = "\(info.process.processName)(\(info.thread.isMainThread ? "Main Thread": "Sub Thread"))"
        let fileString = info.file.components(separatedBy: "/").last ?? ""
        let levelSymbolString = levelSymbol(for: info.level)
        return "\(dateString) \(processString) \(fileString)[\(info.line)] \(info.function) \(levelSymbolString): \(info.message ?? "nil")"
    }
    
    /// 等级对应的符号
    /// - Parameter level: 日志等级
    /// - Returns: 返回对应的符号
    func levelSymbol(for level: DPLogLevel) -> String {
        switch level {
        case .debug:
            return "DEBUG 🐞"
        case .info:
            return "INFO ℹ️"
        case .warning:
            return "WARNING ⚠️"
        case .error:
            return "ERROR ❌"
        default:
            return ""
        }
    }
}
