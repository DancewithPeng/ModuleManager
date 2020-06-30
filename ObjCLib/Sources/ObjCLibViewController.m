//
//  ObjCLibViewController.m
//  ObjCLib
//
//  Created by 张鹏 on 2019/4/20.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "ObjCLibViewController.h"
#import "ObjCLibModule.h"

@interface ObjCLibViewController ()

@end

@implementation ObjCLibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)pushSwiftLibVCButtonDidClick:(id)sender {
    
    UIViewController *objCVC = [ObjCLibModule.bus viewControllerWithURL:@"SwiftLib/SwiftLibViewController" info:nil];
    NSAssert(objCVC != nil && [objCVC isKindOfClass:UIViewController.class], @"viewControllerWithURL返回的类型不正确");
    [self.navigationController pushViewController:objCVC animated:YES];
}

- (IBAction)runSwiftLibServiceButtonDidClick:(id)sender {
    
    [ObjCLibModule.bus runServiceWithName:@"sayHello" info:@{@"baseViewController" : self} callback:^(NSDictionary<NSString *,id> * _Nonnull reusltInfo) {
        NSLog(@"成功啦～～～～");
    }];
}

@end
