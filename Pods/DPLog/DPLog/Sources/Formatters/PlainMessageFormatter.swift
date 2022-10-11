import Foundation

/// 朴素的信息格式器
public class PlainMessageFormatter: MessageFormatter {
    
    private lazy var timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return timeFormatter
    }()
    
    public init() {}
    
    public func format(_ message: Message) -> String {
        
        let timeSymbol     = timeFormatter.string(from: message.time) + ".\(Int(message.time.timeIntervalSince1970 * 1000_000) % 1000_000)"
        let threadSymbol   = message.environment.threadInfo.plainMessageSymbol
        let locationSymbol = message.environment.location.plainMessageSymbol
        let levelSymbol    = message.level.plainMessageSymbol
        
        let subjectSymbol: String
        if let subject = message.subject {
            subjectSymbol = String(describing: subject)
        } else {
            subjectSymbol = "nil"
        }
        
        return "\(timeSymbol) \(threadSymbol) \(locationSymbol) \(levelSymbol) \(subjectSymbol)"
    }
}

extension Message.Level {
    var plainMessageSymbol: String {
        switch self {
        case .debug:
            return "DEBUG 🐞"
        case .info:
            return "INFO 🌀"
        case .warning:
            return "WARNING ⚠️"
        case .error:
            return "ERROR ❌"
        }
    }
}

extension Message.Environment.ThreadInfo {
    var plainMessageSymbol: String {
        return "\(thread.isMainThread ? "[MAIN]" : "[\(threadID)]")"
    }
}

extension Message.Environment.Location {
    var plainMessageSymbol: String {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        return "\(fileName)[\(line)] \(function)"
    }
}
