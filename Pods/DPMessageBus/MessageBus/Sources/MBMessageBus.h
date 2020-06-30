//
//  MBMessageBus.h
//  MessageBus
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 信息处理回调
 */
typedef void (^MBMessageHandingCallback)(NSDictionary<NSString *, id> *);


@class MBMessageBus;


/**
 消息观察者
 */
@protocol MBMessageObserver

@required

/**
 接收到普通消息

 @param bus 总线
 @param message 消息
 @param info 额外的信息
 @return 返回消息处理的结果
 */
- (nullable id)bus:(MBMessageBus *)bus didReceivedMessage:(NSString *)message info:(nullable NSDictionary<NSString *, id> *)info;

/**
 接收到异步消息

 @param bus 总线
 @param message 消息
 @param info 额外的信息
 @param callback 回调操作
 @return 返回消息处理的结果，能处理返回YES，不能处理返回NO
 */
- (BOOL)bus:(MBMessageBus *)bus didReceivedAsyncMessage:(NSString *)message info:(nullable NSDictionary<NSString *, id> *)info callback:(nullable MBMessageHandingCallback)callback;

/**
 接收到广播消息

 @param bus 总线
 @param message 消息
 @param info 额外的信息
 */
- (void)bus:(MBMessageBus *)bus didReceivedPostMessage:(NSString *)message info:(nullable NSDictionary<NSString *, id> *)info;

@end


/**
 消息总线
 */
@interface MBMessageBus : NSObject

@property (nonatomic, copy, readonly) NSString *name;   ///< 总线名称，用户区分不同类型的总线


/**
 初始化方法

 @param name 总线名称
 @return 返回初始化完成的总线对象
 */
- (instancetype)initWithName:(NSString *)name;


/**
 发送普通消息

 @param message 消息
 @param info 额外的信息
 @return 消息处理的结果
 */
- (nullable id)sendMessage:(NSString *)message withInfo:(nullable NSDictionary<NSString *, id> *)info;

/**
 发送异步消息

 @param message 消息
 @param info 额外的信息
 @param callback 回调操作
 @return 消息处理的结果，能处理返回YES，不能处理返回NO
 */
- (BOOL)sendAsyncMessage:(NSString *)message withInfo:(nullable NSDictionary<NSString *, id> *)info callback:(nullable MBMessageHandingCallback)callback;

/**
 发送广播消息

 @param message 消息
 @param info 额外的信息
 */
- (void)postMessage:(NSString *)message withInfo:(nullable NSDictionary<NSString *, id> *)info;



/**
 添加消息观察者，这里采用弱引用，不需要移除观察者

 @param observer 观察者
 */
- (void)addObserver:(id<MBMessageObserver>)observer;

@end


NS_ASSUME_NONNULL_END
