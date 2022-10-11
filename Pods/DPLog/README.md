# DPLog
[TOC]

## 概述

Swift实现的非常轻量级的日志工具



## 导入

```ruby
pod 'DPLog', '~> 3.0.0'
```



## 初始化

**DPLog**在使用前，需要先注册日志处理器，常规操作是在AppDelegate中指定日志处理器

```swift
import DPLog

// ...
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    do {
        try DPLog.Collector.shared.register(
                DPLog.ConsoleHandler(
                    id: "DPLogExample.ConsoleHandler",
                    level: .verbose,
                    formatter: DPLog.PlainMessageFormatter()
                )
            )
    } catch {
        print(error)
    }
  
  	// ...

    return true
}

// ...
```

目前**DPLog.Collector**不支持ObjC的API，如果需要在ObjC项目中初始化，可以先建一个`DPLogCoordinator.swift`文件，然后键入一下内容

```swift
import Foundation
import DPLog

@objc
final class DPLogCoordinator: NSObject {
    
    @objc
    static func setup() {
        do {
            try DPLog.Collector.shared.register(
                    DPLog.ConsoleHandler(
                        id: "DPLogExample.ConsoleHandler",
                        level: .verbose,
                        formatter: DPLog.PlainMessageFormatter()
                    )
                )
        } catch {
            print(error)
        }
    }
}
```

然后在`AppDelegate.m`文件中通过ObjC的API调用`[DPLogCoordinator setup]`

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [DPLogCoordinator setup];    
    return YES;
}
```

在Swift环境中提供了两套API：**ThrowingLog**、**HandyLog**，区别是**ThrowingLog**需要开发者自行处理异常。而**HandyLog**如果发生异常，则会在控制台打印异常，而不需要开发者处理。为了方便，建议开发者设置一个别名

```swift
typealias Log = HandyLog
```

设置后则使用`Log.debug()`的API进行日志采集



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



## LICENSE

此项目采用**MIT**开源协议，[点击查看详情](LICENSE)

