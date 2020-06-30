# ModuleManager

[TOC]

模块管理器，用于模块间的通信和交互的基础工具



## 导入

```ruby
pod 'DPModuleManager', '~> 1.0.0'
```



## 使用

**DPModuleManager**主要提供了两个类型来处理模块间的通信

- **Module**：模块的基类，每个模块应该实现一个**Module**的子类，**DPModuleManager**在启动时会自动加载**Module**的子类到内存中，用于模块间的通信
- **ModuleManager**：与其他模块通信的接口



### 通信的方式

**DPModuleManager**提供了以下几种方式来进行通信

- **URL**：模块间可以通过**URL**来定位并获取到对应的**UIViewController**对象，此方式为同步调用
- **Service**：模块间可以通过服务调用来处理相关的业务功能的调用，此方式为异步调用







### Module子类

这里是实现**Module**子类的一般实现

```swift
// 集成自Module，模块会被自动加载
class MyModule: Module {
    
 		// 返回模块可以处理的URL
    override var canHandleURLs: [String]? {        
      	return ...
    }
    
  	// 返回模块可以处理服务名称
    override var canHandleServiceNames: [String]? {
        return ...
    }
    
  	// 返回URL对应的ViewController
    override func viewController(withURL url: String, info: [String : Any]?) -> UIViewController? {       
      	// ...
        return nil
    }
    
  	// 处理相关的服务调用
    override func runService(withName serviceName: String, info: [String : Any]?, callback: @escaping ([String : Any]) -> Void) -> Bool {        
      	// ...
        return true
    }
    
    // 模块生命周期函数
    override func willLoad() {        
    }
    
  	// 模块生命周期函数
    override func didLoad() {        
    }
    
  	// 便捷的应用生命周期函数接口
    override func applicationWillResignActive(_ application: UIApplication) {
    }
}
```

