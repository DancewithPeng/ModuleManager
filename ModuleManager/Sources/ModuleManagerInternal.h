//
//  ModuleManagerInternal.h
//  ModuleManager
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleBusBridge.h"


NS_ASSUME_NONNULL_BEGIN

/**
 组件管理器
 */
@interface ModuleManager : NSObject <ModuleBusBridge>

/// 单例
@property (class, readonly) ModuleManager *sharedManager;

/**
 初始化，此方法需要在AppDelegate中调用
 */
+ (void)setup;

@end

NS_ASSUME_NONNULL_END
