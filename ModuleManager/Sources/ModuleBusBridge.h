//
//  ModuleBusBridge.h
//  ModuleManager
//
//  Created by 张鹏 on 2019/4/20.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 模块总线桥接，方便调用总线方法
 */
@protocol ModuleBusBridge <NSObject>

- (nullable UIViewController *)viewControllerWithURL:(NSString *)url info:(nullable NSDictionary<NSString *, id> *)info;
- (BOOL)runServiceWithName:(NSString *)serviceName info:(nullable NSDictionary<NSString *, id> *)info callback:(void (^)(NSDictionary<NSString *, id> *))callback;
- (void)postMessage:(NSString *)message info:(nullable NSDictionary<NSString *, id> *)info;

@end

NS_ASSUME_NONNULL_END
