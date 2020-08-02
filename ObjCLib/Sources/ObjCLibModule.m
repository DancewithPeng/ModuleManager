//
//  ObjCLibModule.m
//  ObjCLib
//
//  Created by 张鹏 on 2019/4/20.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "ObjCLibModule.h"
#import "ObjCLibViewController.h"


@implementation ObjCLibModule

- (NSArray<NSString *> *)canHandleURLs {
    return @[
        @"ObjCLib/ObjCLibViewController",
        @"ObjCLib/ObjCLibViewController2",
        @"ObjCLib/MyResources1"
    ];
}

- (UIViewController *)viewControllerWithURL:(NSString *)url info:(NSDictionary<NSString *,id> *)info {
    
    if ([url isEqualToString:@"ObjCLib/ObjCLibViewController"] ||
        [url isEqualToString:@"ObjCLib/ObjCLibViewController2"]) {
        return [[ObjCLibViewController alloc] initWithNibName:@"ObjCLibViewController" bundle: [NSBundle bundleForClass:self.class]];
    }
    
    return nil;
}

- (id)resourcesWithURL:(NSString *)url info:(NSDictionary<NSString *,id> *)info {
    if ([url isEqualToString:@"ObjCLib/MyResources1"]) {
        return @"Hello World！";
    }
    return nil;
}

- (void)willLoad {
    NSLog(@"ObjC模块将要被加载...");
}

- (void)didLoad {
    NSLog(@"ObjC模块已经被加载...");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s, %@", __PRETTY_FUNCTION__, application);
}

@end
