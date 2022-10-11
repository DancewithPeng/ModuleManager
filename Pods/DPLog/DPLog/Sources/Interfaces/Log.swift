import Foundation

// MARK: - ThrowingLog

/// 异常处理的方法集
public enum ThrowingLog {
    
    public static func debug(_ subject: Any?,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line,
                             time: Date = Date()) throws {
        try collect(level: .debug, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    public static func info(_ subject: Any?,
                            file: String = #file,
                            function: String = #function,
                            line: Int = #line,
                            time: Date = Date()) throws {
        try collect(level: .info, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    public static func warning(_ subject: Any?,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line,
                               time: Date = Date()) throws {
        try collect(level: .warning, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    public static func error(_ subject: Any?,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line,
                             time: Date = Date()) throws {
        try collect(level: .error, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    fileprivate static func collect(level: Message.Level,
                                    subject: Any?,
                                    file: String,
                                    function: String,
                                    line: Int,
                                    time: Date,
                                    process: ProcessInfo = ProcessInfo.processInfo,
                                    thread: Thread = Thread.current,
                                    threadID: UInt32 = pthread_mach_thread_np(pthread_self())) throws {
        let message: Message = .init(subject: subject,
                                     level: level,
                                     time: time,
                                     environment: .init(location: .init(file: file,
                                                                        line: line,
                                                                        function: function),
                                                        threadInfo: .init(threadID: threadID,
                                                                          thread: thread,
                                                                          process: process)))
        try Collector.shared.collect(message)
    }
}

// MARK: - HandyLog

/// 便捷的方法集
public enum HandyLog {
    
    public static func debug(_ subject: Any?,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line,
                             time: Date = Date()) {
        collect(level: .debug, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    public static func info(_ subject: Any?,
                            file: String = #file,
                            function: String = #function,
                            line: Int = #line,
                            time: Date = Date()) {
        collect(level: .info, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    public static func warning(_ subject: Any?,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line,
                               time: Date = Date()) {
        collect(level: .warning, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    public static func error(_ subject: Any?,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line,
                             time: Date = Date()) {
        collect(level: .error, subject: subject, file: file, function: function, line: line, time: time)
    }
    
    fileprivate static func collect(level: Message.Level,
                                    subject: Any?,
                                    file: String,
                                    function: String,
                                    line: Int,
                                    time: Date) {
        do {
            try ThrowingLog.collect(level: level, subject: subject, file: file, function: function, line: line, time: time)
        } catch {
            if isDebug {
                print(error)
            }
        }
    }
}

extension HandyLog {
    
    /// 是否调试，调试模式会在标准输出中打印采集失败的原因
    static var isDebug = false
}

// MARK: - ObjCLog

@objc(DPObjCLog)
public final class ObjCLog: NSObject {
    
    @objc
    public static func debug(_ subject: Any?,
                             file: String,
                             function: String,
                             line: Int,
                             time: Date) {
        HandyLog.debug(subject, file: file,  function: function, line: line, time: time)
    }
    
    @objc
    public static func info(_ subject: Any?,
                            file: String,
                            function: String,
                            line: Int,
                            time: Date) {
        HandyLog.info(subject, file: file,  function: function, line: line, time: time)
    }
    
    @objc
    public static func warning(_ subject: Any?,
                               file: String,
                               function: String,
                               line: Int,
                               time: Date) {
        HandyLog.warning(subject, file: file,  function: function, line: line, time: time)
    }
    
    @objc
    public static func error(_ subject: Any?,
                             file: String,
                             function: String,
                             line: Int,
                             time: Date) {
        HandyLog.error(subject, file: file,  function: function, line: line, time: time)
    }
}
