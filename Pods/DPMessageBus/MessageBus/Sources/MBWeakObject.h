//
//  MBWeakObject.h
//  MessageBus
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 弱引用的对象
 */
@interface MBWeakObject : NSObject

@property (nonatomic, weak) id object;  ///< 弱引用的对象

/**
 初始化方法

 @param object 需要引用的对象
 @return 返回MBWeakObject的实例
 */
- (instancetype)initWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END
