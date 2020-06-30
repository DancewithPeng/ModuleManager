//
//  MethodExchange.h
//  ObjCRuntime
//
//  Created by 张鹏 on 2019/8/14.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#ifndef MethodSwizzle_h
#define MethodSwizzle_h

#import <objc/runtime.h>

/**
 方法交换
 
 这里为了调用安全起见，要求交换的两个方法：
 - 来自同一个类
 - 参数签名一致

 @param cls 执行方法交换的类
 @param firstSelector 第一个方法
 @param secondSelector 第二个方法
 @return 如果交换成功，返回YES，反之返回NO
 */
BOOL MethodExchange(Class cls, SEL firstSelector, SEL secondSelector);

/**
 类方法交换
 
 这里为了调用安全起见，要求交换的两个方法：
 - 来自同一个类
 - 参数签名一致
 
 @param cls 执行方法交换的类
 @param firstSelector 第一个方法
 @param secondSelector 第二个方法
 @return 如果交换成功，返回YES，反之返回NO
 */
BOOL ClassMethodExchange(Class cls, SEL firstSelector, SEL secondSelector);

#endif /* MethodSwizzle_h */
