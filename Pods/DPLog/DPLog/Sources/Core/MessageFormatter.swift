import Foundation

/// 日志消息格式器
public protocol MessageFormatter {
    func format(_ message: Message) -> String
}
