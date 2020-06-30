//
//  UIApplication+ModuleManager.m
//  ModuleManager
//
//  Created by 张鹏 on 2019/8/14.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "UIApplication+ModuleManager.h"
#import <DPObjCRuntime/ObjCRuntime.h>
#import <DPLog/DPLog.h>
#import <objc/runtime.h>
#import "ModuleManagerInternal.h"


@implementation UIApplication (ModuleManager)

+ (void)load {
    MethodExchange(self, @selector(setDelegate:), @selector(dp_swizzleSetDelegate:));
}

- (void)dp_swizzleSetDelegate:(id<UIApplicationDelegate>)delegate {
    [self dp_swizzleSetDelegate:delegate];
    
    Method delegateLaunchMethod = class_getInstanceMethod(delegate.class, @selector(application:didFinishLaunchingWithOptions:));
    Method selfSwizzleLaunchMethod = class_getInstanceMethod(self.class, @selector(dp_swizzleApplication:didFinishLaunchingWithOptions:));
    
    BOOL isAddSwizzleMethodToDelegateSuccess = class_addMethod(delegate.class, method_getName(selfSwizzleLaunchMethod), method_getImplementation(selfSwizzleLaunchMethod), method_getTypeEncoding(selfSwizzleLaunchMethod));
    
    // 已经存在，证明已经执行过Swizzle，不需要再进行任何处理
    if (isAddSwizzleMethodToDelegateSuccess == NO) {
        return;
    }
    
    Method delegateSwizzleLaunchMethod = class_getInstanceMethod(delegate.class, method_getName(selfSwizzleLaunchMethod));
    if (delegateSwizzleLaunchMethod == nil) {
        DPLogError(@"给delegate添加Swizzle方法失败");
        return;
    }
    
    BOOL ret = MethodExchange(delegate.class, method_getName(delegateLaunchMethod), method_getName(delegateSwizzleLaunchMethod));
    if (ret == NO) {
        DPLogError(@"delegate的Swizzle方法交换失败");
        return;
    }
}

- (BOOL)dp_swizzleApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 先加载模块
    [ModuleManager setup];
    
    // 再执行`didFinishLaunchingWithOptions`
    BOOL ret = [self dp_swizzleApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return ret;
}


@end
