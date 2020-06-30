//
//  DPLogObjC.h
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DPLogInterface
#define DPLogInterface

#define DPLogError(fmt, ...) do { \
    [DPLog logErrorWithFile:__FILE__ \
                   function: __PRETTY_FUNCTION__ \
                       line:__LINE__ \
                     format:(fmt), ##__VA_ARGS__]; \
} while(0)

#define DPLogWarning(fmt, ...) do { \
    [DPLog logWarningWithFile:__FILE__ \
                     function: __PRETTY_FUNCTION__ \
                         line:__LINE__ \
                       format:(fmt), ##__VA_ARGS__]; \
} while(0)

#define DPLogInfo(fmt, ...) do { \
    [DPLog logInfoWithFile:__FILE__ \
                  function: __PRETTY_FUNCTION__ \
                      line:__LINE__ \
                    format:(fmt), ##__VA_ARGS__]; \
} while(0)

#define DPLogDebug(fmt, ...) do { \
    [DPLog logDebugWithFile:__FILE__ \
                   function: __PRETTY_FUNCTION__ \
                       line:__LINE__ \
                     format:(fmt), ##__VA_ARGS__]; \
} while(0)

#endif

NS_ASSUME_NONNULL_BEGIN

/// DPLog对应的ObjC接口
@interface DPLog : NSObject

/// 初始化配置，指定日志记录仪
/// @param loggers 日志记录仪，类型必须是遵循Logger协议的对象
+ (void)setupWithLoggers:(NSArray *)loggers;

/// 输出Error级别日志
+ (void)logErrorWithFile:(const char *)file
                function:(const char *)function
                    line:(NSInteger)line
                  format:(id)format, ...;

/// 输出Warning级别日志
+ (void)logWarningWithFile:(const char *)file
                  function:(const char *)function
                      line:(NSInteger)line
                    format:(id)format, ...;

/// 输出Info级别日志
+ (void)logInfoWithFile:(const char *)file
               function:(const char *)function
                   line:(NSInteger)line
                 format:(id)format, ...;

/// 输出Debug级别日志
+ (void)logDebugWithFile:(const char *)file
                function:(const char *)function
                    line:(NSInteger)line
                  format:(id)format, ...;

@end

NS_ASSUME_NONNULL_END
