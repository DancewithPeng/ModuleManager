import Foundation

/// 日志处理器
public protocol Handler {
    var id: String { get }
    var level: Message.HandleableLevel { get }
    var formatter: MessageFormatter { get }
    
    func handle(_ messagePresentation: String)
}
