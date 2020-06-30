//
//  MBWeakObject.m
//  MessageBus
//
//  Created by 张鹏 on 2019/4/19.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

#import "MBWeakObject.h"

@implementation MBWeakObject

- (instancetype)initWithObject:(id)object {
    if (self = [super init]) {
        self.object = object;
    }
    
    return self;
}

@end
