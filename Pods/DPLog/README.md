# DPLog
[TOC]

日志工具

## 导入

```ruby
pod 'DPLog', '~> 2.0.0'
```



## 基本使用

可以直接输出字符串到日志

```swift
Log.debug("My Debug")
Log.info("My Info")
Log.warning("My Warning")
Log.error("My Error")
```

对应的**ObjC**语法

```objective-c
DPLogDebug(@"My Debug");
DPLogInfo(@"My Info");
DPLogWarning(@"My Warning");
DPLogError(@"My Error");
```

除了直接输出字符串到日志，**DPLog**还支持直接输出一个对象，此时会输出对象的`description`属性

```swift
let myError = NSError(domain: "dp.log.demo",
												code: 100001,
										userInfo: [NSLocalizedFailureReasonErrorKey: "Error Demo",
 																			NSLocalizedDescriptionKey: "Just a Demo"])
Log.error(myError)
```

对应的**ObjC**语法

```objective-c
NSError *myError = 
  	[NSError errorWithDomain:@"dp.log.demo"
												code:100001
										userInfo:@{NSLocalizedFailureReasonErrorKey: @"Error Demo",
																			NSLocalizedDescriptionKey: @"Just a Demo"}];
DPLogError(myError);
```



### 日志等级配置

**DPLog**默认的日志等级是`debug`，如果需要根据不同的环境进行配置，可以在适当的情况下配置**DPLog**的`Logger`

```swift
#if DEBUG
		Log.setup(loggers: [DPConsoleLogger(logLevel: .debug)])
#else
		Log.setup(loggers: [DPConsoleLogger(logLevel: .error)])
#endif
```

> `DPConsoleLogger`是**DPLog**实现的默认*Logger*，它的作用是将日志输出到控制台。如果想要控制日志输出到其他目标，请参考下面自定义的相关章节

对应的**ObjC**语法

```objective-c
    DPLogDefaultFormatter *defaultFormatter = [[DPLogDefaultFormatter alloc] initWithDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
#ifdef DEBUG
    [DPLog setupWithLoggers:@[
        [[DPConsoleLogger alloc] initWithLogLevel:DPLogLevelDebug formatter:defaultFormatter],
    ]];
#else
    [DPLog setupWithLoggers:@[
        [[DPConsoleLogger alloc] initWithLogLevel:DPLogLevelError formatter:defaultFormatter],
    ]];
#endif
```



## 自定义

**DPLog**可以自定义*Logger*，用于控制日志的输出目标，同时也可以自定义*Logger*的输出格式

> **DPLog**提供了控制台*Logger*的默认实现`DPConsoleLogger`，以及`DPLogFormatter`的默认实现`DPLogDefaultFormatter`，如果两者的已经满足了您的需求，则不需要重新自定相关实现，直接使用即可



### 自定义Logger

自定义*Logger*的方法非常简单，只需要遵循`DPLogger`协议，此协议规定规定了两个属性和一个方法

- 属性**logLevel**：用于指定*Logger*的日志输出等级，低于*Logger*的日志输出等级的日志将不会被输出到*Logger*
- 属性**formatter**：用于控制输出到*Logger*的信息格式工具，类型是`DPLogFormatter`，次类型也可以进行自定义，或者使用**DPLog**提供的默认格式`DPLogDefaultFormatter`
- 方法`log(message:)`：用于处理日志输出的钩子，这里的`message`参数是已经进行过格式化的字符串

细节请参考`DPConsoleLogger`的具体实现



### 自定义Formatter

实现自己的*Formatter*，需要遵循`DPLogFormatter`协议，此协议只规定了一个方法

- 方法`formatString(for:)`：此方法用于把接口传过来的信息，转化成需要输出到日志的字符串，接口传过来的信息用`DPLogInformation`进行了封装

细节请参考`DPLogDefaultFormatter`的具体实现



## LICENSE

此项目采用**MIT**开源协议，[点击查看详情](LICENSE)

