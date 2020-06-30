//
//  ViewController.m
//  ObjCApp
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <ModuleManager/ModuleManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)objcLibButtonDidClick:(id)sender {
    UIViewController *objCVC = [Module.bus viewControllerWithURL:@"ObjCLib/ObjCLibViewController" info:nil];
    NSAssert(objCVC != nil && [objCVC isKindOfClass:UIViewController.class], @"viewControllerWithURL返回的类型不正确");
    [self.navigationController pushViewController:objCVC animated:YES];
}

- (IBAction)swiftLibButtonDidClick:(id)sender {
    
    UIViewController *objCVC = [Module.bus viewControllerWithURL:@"SwiftLib/SwiftLibViewController" info:nil];
    NSAssert(objCVC != nil && [objCVC isKindOfClass:UIViewController.class], @"viewControllerWithURL返回的类型不正确");
    [self.navigationController pushViewController:objCVC animated:YES];
}


@end
