import Foundation

/// 日志采集器
public final class Collector {
    public static let shared = Collector()
    public private(set) var handlers: [Handler] = []
    private init() {}
}

extension Collector {
    
    /// 采集消息
    public func collect(_ message: Message) throws {
        
        let matchedLevelHandlers = handlers.filter({ message.level.rawValue >= $0.level.rawValue })
        guard matchedLevelHandlers.count > 0 else {
            throw Error.missingMatchedLevelHandler(message, handlers)
        }
        
        /// 并发处理消息
        DispatchQueue.concurrentPerform(iterations: matchedLevelHandlers.count) { index in
            let handler      = matchedLevelHandlers[index]
            let presentation = handler.formatter.format(message)
            handler.handle(presentation)
        }
    }
    
    /// 注册处理器
    public func register(_ handler: Handler) throws {
        guard handlers.contains(where: { handler.id == $0.id }) == false else {
            throw Error.handlerAlreadyExists
        }
        
        handlers.append(handler)
    }

    /// 移除处理器
    public func remove(_ handler: Handler) throws -> Handler {
        guard let index = handlers.firstIndex(where: { handler.id == $0.id }) else {
            throw Error.handlerNotExists
        }
        
        return handlers.remove(at: index)
    }
}

extension Collector {
    
    /// 采集器错误
    enum Error: Swift.Error {
        case missingMatchedLevelHandler(Message, [Handler])
        case handlerAlreadyExists
        case handlerNotExists
    }
}
