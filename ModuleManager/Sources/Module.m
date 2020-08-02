//
//  Module.m
//  ModuleManager
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "Module.h"
#import "ModuleManagerInternal.h"


@implementation Module


# pragma mark - Interfaces

+ (id<ModuleBusBridge>)bus {
    return [ModuleManager sharedManager];
}


# pragma mark - Subclassing Hooks

- (NSArray<NSString *> *)canHandleURLs { return nil; }
- (NSArray<NSString *> *)canHandleServiceNames { return nil; }
- (UIViewController *)viewControllerWithURL:(NSString *)url info:(NSDictionary<NSString *,id> *)info { return nil; }
- (id)resourcesWithURL:(NSString *)url info:(NSDictionary<NSString *,id> *)info { return nil; }
- (BOOL)runServiceWithName:(NSString *)serviceName info:(NSDictionary<NSString *,id> *)info callback:(void (^)(NSDictionary<NSString *,id> * _Nonnull))callback { return NO; }
- (void)receivedMessage:(NSString *)message info:(nullable NSDictionary<NSString *, id> *)info {}


#pragma mark - Life Cycle Hooks

- (void)willLoad {}
- (void)didLoad {}


#pragma mark - Application Life Cycle Hooks

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {}

@end
