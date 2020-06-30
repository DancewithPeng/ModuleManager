//
//  Module.h
//  ModuleManager
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleBusBridge.h"

NS_ASSUME_NONNULL_BEGIN

/**
 组件基类
 */
@interface Module : NSObject

@property (nonatomic, readonly, class) id<ModuleBusBridge> bus; ///< 调用总线方法

@end


/**
 组件的基类应该重写的方法
 组件如果想要提供相关的页面和服务，应该通过重写这组方法来提供
 */
@interface Module (SubclassingHooks)

@property (nonatomic, readonly, nullable) NSArray<NSString *> *canHandleURLs;          ///< 可以处理的URL
@property (nonatomic, readonly, nullable) NSArray<NSString *> *canHandleServiceNames;  ///< 可以处理的服务名称

/**
 根据`URL`和`info`返回对应的`ViewController`

 @param url 对应的URL
 @param info 对应info
 @return 如果模块内部能处理URL，并且info的参数正确，返回对应的`ViewController`对象，反之则返回nil
 */
- (nullable UIViewController *)viewControllerWithURL:(NSString *)url info:(nullable NSDictionary<NSString *, id> *)info;

/**
 运行自定的服务

 @param serviceName 服务名称
 @param info 对应的info
 @param callback 运行服务后的回调
 @return 如果模块内部可以处理`serviceName`，并且info的参数正确，模块会执行相关的服务，并且执行callback回调，此方法返回YES，反之返回NO
 */
- (BOOL)runServiceWithName:(NSString *)serviceName info:(nullable NSDictionary<NSString *, id> *)info callback:(void (^)(NSDictionary<NSString *, id> *))callback;

/**
 接收信息

 @param message 接收到的信息
 @param info 以及对应的参数
 */
- (void)receivedMessage:(NSString *)message info:(nullable NSDictionary<NSString *, id> *)info;


#pragma mark - Life Cycle Hooks

/**
 模块将要被加载到系统中
 */
- (void)willLoad;

/**
 模块已经被加载到系统中
 */
- (void)didLoad;


#pragma mark - Application Life Cycle Hooks

// 应用程序的生命周期函数
//
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
