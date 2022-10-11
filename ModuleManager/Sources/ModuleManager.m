//
//  ModuleManager.m
//  ModuleManager
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "ModuleManagerInternal.h"
#import "Module.h"
#import <objc/runtime.h>
#import <DPMessageBus/MBMessageBus.h>
#import <DPLog/DPLog.h>
#import <DPLog/DPLog-Swift.h>

@interface ModuleManager () <MBMessageObserver>

@property (nonatomic, strong, readonly) NSMutableArray<Module *> *modules;  ///< 模块数组
@property (nonatomic, strong, readonly) MBMessageBus *uiBus;                ///< UI总线
@property (nonatomic, strong, readonly) MBMessageBus *serviceBus;           ///< 服务总线
@property (nonatomic, strong, readonly) MBMessageBus *messageBus;           ///< 消息总线
@property (nonatomic, strong, readonly) MBMessageBus *resourcesBus;         ///< 资源总线

@end

@implementation ModuleManager

@synthesize modules = _modules;
@synthesize uiBus = _uiBus;
@synthesize serviceBus = _serviceBus;
@synthesize messageBus = _messageBus;
@synthesize resourcesBus = _resourcesBus;


- (instancetype)init {
    if (self = [super init]) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}


# pragma mark - Interfaces

+ (instancetype)sharedManager {
    
    static ModuleManager *_manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ModuleManager alloc] init];
    });
    
    return _manager;
}

+ (void)setup {    
    [[ModuleManager sharedManager] loadAllModules];
}


# pragma mark - ModuleBusBridge

// Bus 想要获取对应的ViewController
- (UIViewController *)viewControllerWithURL:(NSString *)url info:(NSDictionary<NSString *,id> *)info {
    return [self.uiBus sendMessage:url withInfo:info];
}

// Bus 想要获取对应的资源
- (id)resourcesWithURL:(NSString *)url info:(NSDictionary<NSString *,id> *)info {
    return [self.resourcesBus sendMessage:url withInfo:info];
}

// Bus 想要运行相关的服务
- (BOOL)runServiceWithName:(NSString *)serviceName info:(NSDictionary<NSString *,id> *)info callback:(void (^)(NSDictionary<NSString *,id> * _Nonnull))callback {
    return [self.serviceBus sendAsyncMessage:serviceName withInfo:info callback:callback];
}

// Bus 想要发送广播信息
- (void)postMessage:(NSString *)message info:(NSDictionary<NSString *,id> *)info {
    [self.messageBus postMessage:message withInfo:info];
}


# pragma mark - MBMessageObserver

- (id)bus:(MBMessageBus *)bus didReceivedMessage:(NSString *)message info:(NSDictionary<NSString *,id> *)info {
    
    // UI总线只处理UI相关的东西
    if (bus == self.uiBus) {
        for (int i=0; i<self.modules.count; i++) {
            Module *m = self.modules[i];
            if ([m.canHandleURLs containsObject:message] == NO) {
                continue;
            }
            id ret = [m viewControllerWithURL:message info:info];
            if ([ret isKindOfClass:UIViewController.class]) {
                return ret;
            }
        }
        
        DPLogError(@"没有组件可以处理这个URL：%@ info: %@", message, info ? info : @"nil");
        return nil;
    }
    
    if (bus == self.resourcesBus) {
        for (int i=0; i<self.modules.count; i++) {
            Module *m = self.modules[i];
            if ([m.canHandleURLs containsObject:message] == NO) {
                continue;
            }
            id ret = [m resourcesWithURL:message info:info];
            if (ret != nil) {
                return ret;
            }
        }
        DPLogError(@"没有组件可以处理这个URL：%@ info: %@", message, info ? info : @"nil");
        return nil;
    }
    
    DPLogError(@"没有组件可以处理这个URL：%@ info: %@", message, info ? info : @"nil");
    return nil;
}

- (BOOL)bus:(MBMessageBus *)bus didReceivedAsyncMessage:(NSString *)message info:(NSDictionary<NSString *,id> *)info callback:(MBMessageHandingCallback)callback {

    // 服务总线只处理服务总线的消息
    if (bus != self.serviceBus) {
        return NO;
    }
    
    for (int i=0; i<self.modules.count; i++) {
        Module *m = self.modules[i];
        if ([m.canHandleServiceNames containsObject:message] == NO) {
            continue;
        }
        return [m runServiceWithName:message info:info callback:callback];
    }
    
    DPLogError(@"没有组件可以处理这个服务：%@ info: %@", message, info ? info : @"nil");
    
    return NO;
}

- (void)bus:(MBMessageBus *)bus didReceivedPostMessage:(NSString *)message info:(NSDictionary<NSString *,id> *)info {
    
    // 消息总线只处理消息总线的信息
    if (bus != self.messageBus) {
        return;
    }
    
    for (int i=0; i<self.modules.count; i++) {
        Module *m = self.modules[i];
        [m receivedMessage:message info:info];
    }
}


# pragma mark - Notification Handlers

- (void)applicationWillResignActive:(NSNotification *)notification {
    [self.modules enumerateObjectsUsingBlock:^(Module * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj applicationWillResignActive:[UIApplication sharedApplication]];
    }];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    [self.modules enumerateObjectsUsingBlock:^(Module * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj applicationDidEnterBackground:[UIApplication sharedApplication]];
    }];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    [self.modules enumerateObjectsUsingBlock:^(Module * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj applicationWillEnterForeground:[UIApplication sharedApplication]];
    }];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [self.modules enumerateObjectsUsingBlock:^(Module * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj applicationDidBecomeActive:[UIApplication sharedApplication]];
    }];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    [self.modules enumerateObjectsUsingBlock:^(Module * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj applicationWillTerminate:[UIApplication sharedApplication]];
    }];
}

- (void)applicationDidReceiveMemoryWarning:(NSNotification *)notification {
    [self.modules enumerateObjectsUsingBlock:^(Module * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj applicationDidReceiveMemoryWarning:[UIApplication sharedApplication]];
    }];
}


# pragma mark - Helper Methods

/**
 加载所有模块
 */
- (void)loadAllModules {
    
    int numClasses;
    Class * classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0 ) {
        classes = (Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        
        Class supCls = Module.class;
        for (int i=0; i<numClasses; i++) {
            Class cls = classes[i];
            if (class_getSuperclass(cls) == supCls) {
                Module *m = [[cls alloc] init];
                [self.modules addObject:m];
                [m willLoad];
            }
        }
        
        free(classes);
    }
    
    // 调用`didLoad`声明周期
    for (Module *m in self.modules) {
        [m didLoad];
    }
}


# pragma mark - Getters

- (NSMutableArray<Module *> *)modules {
    if (_modules == nil) {
        _modules = [[NSMutableArray alloc] init];
    }
    
    return _modules;
}

- (MBMessageBus *)uiBus {
    if (_uiBus == nil) {
        _uiBus = [[MBMessageBus alloc] initWithName:@"uiBus"];
        [_uiBus addObserver:self];
    }
    
    return _uiBus;
}

- (MBMessageBus *)serviceBus {
    if (_serviceBus == nil) {
        _serviceBus = [[MBMessageBus alloc] initWithName:@"serviceBus"];
        [_serviceBus addObserver:self];
    }
    
    return _serviceBus;
}

- (MBMessageBus *)messageBus {
    if (_messageBus == nil) {
        _messageBus = [[MBMessageBus alloc] initWithName:@"messageBus"];
        [_messageBus addObserver:self];
    }
    
    return _messageBus;
}

- (MBMessageBus *)resourcesBus {
    if (_resourcesBus == nil) {
        _resourcesBus = [[MBMessageBus alloc] initWithName:@"resourcesBus"];
        [_resourcesBus addObserver:self];
    }
    return _resourcesBus;
}

@end
