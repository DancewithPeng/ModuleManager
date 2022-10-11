import Foundation

/// 日志消息
public struct Message {
    public let subject: Any?
    public let level: Level
    public let time: Date
    public let environment: Environment
    
    public init(subject: Any?, level: Level, time: Date, environment: Environment) {
        self.subject     = subject
        self.level       = level
        self.time        = time
        self.environment = environment
    }
}

extension Message {
    
    /// 消息等级
    public enum Level: UInt {
        case debug   = 10
        case info    = 20
        case warning = 30
        case error   = 40
    }
    
    /// 消息可处理等级
    public enum HandleableLevel: UInt {
        case verbose = 0
        case debug   = 10
        case info    = 20
        case warning = 30
        case error   = 40
        case none    = 999999
    }
    
    /// 环境
    public struct Environment {
        public let location: Location
        public let threadInfo: ThreadInfo
        
        public init(location: Location, threadInfo: ThreadInfo) {
            self.location   = location
            self.threadInfo = threadInfo
        }
    }
}

extension Message.Environment {
    
    /// 位置
    public struct Location {
        public let file: String
        public let line: Int
        public let function: String
        
        public init(file: String, line: Int, function: String) {
            self.file     = file
            self.line     = line
            self.function = function
        }
    }
    
    /// 线程信息
    public struct ThreadInfo {
        public let threadID: UInt32
        public let thread: Thread
        public let process: ProcessInfo
        
        public init(threadID: UInt32, thread: Thread, process: ProcessInfo) {
            self.threadID = threadID
            self.thread   = thread
            self.process  = process
        }
    }
}
