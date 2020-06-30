# MessageBus

[TOC]

消息总线，用于组件化的基础组件



## 导入

```ruby
pod 'DPMessageBus', '~> 1.0'
```



## 使用

初始化

```objective-c
MBMessageBus *messageBus = [[MBMessageBus alloc] initWithName:@"MyMessageBus"];
```

可以给**MBMessageBus**添加观察者，观察者这里使用了弱引用，添加后不需要手动移除。观察者需要遵循`MBMessageObserver`协议，用于处理收到的信息

```objective-c
[messageBus addObserver:self];
```

通过总线发送消息

```objective-c
// 发送同步信息
[messageBus sendMessage:@"MyMessage" withInfo:@{@"MyInfoKey": ...}];    

// 发送异步信息
[messageBus sendAsyncMessage:@"MyAsyncMessage" withInfo:@{@"MyInfoKey": ...} callback:^(NSDictionary<NSString *,id> * _Nonnull info) {
  	NSLog(@"callbackInfo: %@", info);
}];
    
// 发送广播信息
[messageBus postMessage:@"MyPostMessage" withInfo:@{@"MyInfoKey": ...}];
```



## LICENSE

此项目采用**MIT**开源协议，[点击查看详情](LICENSE)

