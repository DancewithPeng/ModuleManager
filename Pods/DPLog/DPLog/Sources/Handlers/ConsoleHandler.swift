import Foundation


/// 控制台格式日志处理器
public final class ConsoleHandler: Handler {
    
    public let id: String
    public let level: Message.HandleableLevel
    public var formatter: MessageFormatter
    private let serialQueue: DispatchQueue
    
    public init(id: String, level: Message.HandleableLevel, formatter: MessageFormatter) {
        self.id          = id
        self.level       = level
        self.formatter   = formatter
        self.serialQueue = DispatchQueue(label: "serialQueue")
    }
        
    public func handle(_ messagePresentation: String) {
        serialQueue.async {
            print(messagePresentation)
        }
    }
}

extension ConsoleHandler: CustomStringConvertible {
    public var description: String {
        return "ConsoleHandler(id: \(id), level: \(level), formatter: \(formatter), serialQueue: \(serialQueue))"
    }
}
