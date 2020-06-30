//
//  MBMessageBus.m
//  MessageBus
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "MBMessageBus.h"
#import "MBWeakObject.h"


@interface MBMessageBus ()

@property (nonatomic, strong) NSMutableArray<MBWeakObject *> *observers; ///< 观察者

@end

@implementation MBMessageBus

@synthesize name = _name;


# pragma mark - Interfaces

// 初始化
- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = [name copy];
    }
    
    return self;
}

// 发送普通消息
- (id)sendMessage:(NSString *)message withInfo:(NSDictionary<NSString *,id> *)info {
    
    __block id result = nil;
    
    [self enumerateObserversUsingBlock:^(id<MBMessageObserver> observer, BOOL * stop) {
        result = [observer bus:self didReceivedMessage:message info:info];
        if (result) {
            *stop = YES;
        }
    }];
    
    return result;
}

// 发送异步消息
- (BOOL)sendAsyncMessage:(NSString *)message withInfo:(NSDictionary<NSString *,id> *)info callback:(MBMessageHandingCallback)callback {
    
    __block BOOL result = NO;
    
    [self enumerateObserversUsingBlock:^(id<MBMessageObserver> observer, BOOL * stop) {
        result = [observer bus:self didReceivedAsyncMessage:message info:info callback:callback];
        if (result == YES) {
            *stop = YES;
        }
    }];
    
    return result;
}

// 发送广播消息
- (void)postMessage:(NSString *)message withInfo:(NSDictionary<NSString *,id> *)info {
    [self enumerateObserversUsingBlock:^(id<MBMessageObserver> observer, BOOL * stop) {
        [observer bus:self didReceivedPostMessage:message info:info];
    }];
}

// 添加观察者
- (void)addObserver:(id<MBMessageObserver>)observer {
    [self.observers addObject:[[MBWeakObject alloc] initWithObject:observer]];
}


# pragma mark - Helper Methods

/**
 遍历所有观察者，并执行Block

 @param block 遍历观察者时执行的Block
 */
- (void)enumerateObserversUsingBlock:(void (^)(id<MBMessageObserver>, BOOL *))block {
    
    NSMutableArray *needsRemoveIndexs = [[NSMutableArray alloc] init];
    for (int i=0; i<self.observers.count; i++) {
        MBWeakObject *weakObj = self.observers[i];
        
        if (weakObj.object != nil) {
            id<MBMessageObserver> observer = weakObj.object;
            
            if (block != nil) {
                BOOL isStop = NO;
                block(observer, &isStop);
                
                if (isStop) {
                    break;
                }
            }
            
        } else {
            [needsRemoveIndexs insertObject:@(i) atIndex:0];
        }
    }
    
    for (int k=0; k<needsRemoveIndexs.count; k++) {
        [self.observers removeObjectAtIndex: [needsRemoveIndexs[k] integerValue]];
    }
}


# pragma mark - Getters

- (NSMutableArray<MBWeakObject *> *)observers {
    if (_observers == nil) {
        _observers = [[NSMutableArray alloc] init];
    }
    
    return _observers;
}

@end
