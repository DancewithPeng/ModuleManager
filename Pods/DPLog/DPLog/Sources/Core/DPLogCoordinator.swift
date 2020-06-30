//
//  Coordinator.swift
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 日志协调器
@objc
public class DPLogCoordinator: NSObject {
    
    /// 单例入口
    @objc
    public static let shared = DPLogCoordinator()
    
    /// 日志记录器
    private var loggers: [DPLogger]
    
    /// 初始化方法
    @objc
    public override init() {
        self.loggers = [DPConsoleLogger()]
    }
    
    /// 配置协调器
    @objc
    public func setup(loggers: [DPLogger]) {
        self.loggers = loggers
    }
    
    /// 输出日志信息
    @objc
    public func log(information: DPLogInformation) {
        for logger in loggers {
            if information.level.rawValue >= logger.logLevel.rawValue {
                logger.log(message: logger.formatter.formatString(for: information))
            }
        }
    }
}
