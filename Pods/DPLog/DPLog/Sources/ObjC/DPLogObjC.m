//
//  DPLogObjC.m
//  DPLog
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "DPLogObjC.h"
#import <DPLog/DPLog-Swift.h>
#import <pthread.h>

@implementation DPLog

+ (void)setupWithLoggers:(NSArray *)loggers {
    [DPLogCoordinator.shared setupWithLoggers:loggers];
}

+ (void)logErrorWithFile:(const char *)file
                function:(const char *)function
                    line:(NSInteger)line
                  format:(id)format, ... {
    va_list args;
    if (format) {
        NSString *message = nil;
        if ([format isKindOfClass:NSString.class]) {
            va_start(args, format);
            message = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
        } else {
            message = [NSString stringWithFormat:@"%@", format];
        }
        
        DPLogInformation *info =
        [[DPLogInformation alloc] initWithMessage:message
                                            level:DPLogLevelError
                                             file:[NSString stringWithCString:file encoding:NSUTF8StringEncoding]
                                             line:line
                                         function:[NSString stringWithCString:function encoding:NSUTF8StringEncoding]
                                             date:[NSDate date]
                                          process:NSProcessInfo.processInfo
                                           thread:NSThread.currentThread
                                         threadID:pthread_mach_thread_np(pthread_self())];
        [DPLogCoordinator.shared logWithInformation:info];
    }
}

+ (void)logWarningWithFile:(const char *)file
                  function:(const char *)function
                      line:(NSInteger)line
                    format:(id)format, ... {
    va_list args;
    if (format) {
        NSString *message = nil;
        if ([format isKindOfClass:NSString.class]) {
            va_start(args, format);
            message = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
        } else {
            message = [NSString stringWithFormat:@"%@", format];
        }
        
        DPLogInformation *info =
        [[DPLogInformation alloc] initWithMessage:message
                                            level:DPLogLevelWarning
                                             file:[NSString stringWithCString:file encoding:NSUTF8StringEncoding]
                                             line:line
                                         function:[NSString stringWithCString:function encoding:NSUTF8StringEncoding]
                                             date:[NSDate date]
                                          process:NSProcessInfo.processInfo
                                           thread:NSThread.currentThread
                                         threadID:pthread_mach_thread_np(pthread_self())];
        [DPLogCoordinator.shared logWithInformation:info];
    }
}

+ (void)logInfoWithFile:(const char *)file
               function:(const char *)function
                   line:(NSInteger)line
                 format:(id)format, ... {
    va_list args;
    if (format) {
        NSString *message = nil;
        if ([format isKindOfClass:NSString.class]) {
            va_start(args, format);
            message = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
        } else {
            message = [NSString stringWithFormat:@"%@", format];
        }
        
        DPLogInformation *info =
        [[DPLogInformation alloc] initWithMessage:message
                                            level:DPLogLevelInfo
                                             file:[NSString stringWithCString:file encoding:NSUTF8StringEncoding]
                                             line:line
                                         function:[NSString stringWithCString:function encoding:NSUTF8StringEncoding]
                                             date:[NSDate date]
                                          process:NSProcessInfo.processInfo
                                           thread:NSThread.currentThread
                                         threadID:pthread_mach_thread_np(pthread_self())];
        [DPLogCoordinator.shared logWithInformation:info];
    }
}

+ (void)logDebugWithFile:(const char *)file
                function:(const char *)function
                    line:(NSInteger)line
                  format:(id)format, ... {
    va_list args;
    if (format) {
        NSString *message = nil;
        if ([format isKindOfClass:NSString.class]) {
            va_start(args, format);
            message = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
        } else {
            message = [NSString stringWithFormat:@"%@", format];
        }
        
        DPLogInformation *info =
        [[DPLogInformation alloc] initWithMessage:message
                                            level:DPLogLevelDebug
                                             file:[NSString stringWithCString:file encoding:NSUTF8StringEncoding]
                                             line:line
                                         function:[NSString stringWithCString:function encoding:NSUTF8StringEncoding]
                                             date:[NSDate date]
                                          process:NSProcessInfo.processInfo
                                           thread:NSThread.currentThread
                                         threadID:pthread_mach_thread_np(pthread_self())];
        [DPLogCoordinator.shared logWithInformation:info];
    }
}

@end
