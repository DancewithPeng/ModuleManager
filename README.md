# ModuleManager

[TOC]

模块管理器，用于模块间的通信和交互的基础工具



## 导入

```ruby
pod 'DPModuleManager', '~> 1.0.1'
```



## 使用

**DPModuleManager**主要提供了两个类型来处理模块间的通信

- **Module**：模块的基类，每个模块应该实现一个**Module**的子类，**DPModuleManager**在启动时会自动加载**Module**的子类到内存中，用于模块间的通信
- **ModuleManager**：与其他模块通信的接口



### 通信的方式

**DPModuleManager**提供了以下几种方式来进行通信

- **URL**：模块间可以通过**URL**来定位并获取到对应的**UIViewController**对象，此方式为同步调用
- **Service**：模块间可以通过服务调用来处理相关的业务功能的调用，此方式为异步调用



#### 通过URL获取到对应的UIViewController

调用方通过*URL*获取对应的*UIViewController*对象，这里的URL为指定的字符串，你可以随意指定，但是个人建议和页面路由对应

这里以模拟的*问题详情页*来进行举例，这里的必要参数`questionID`，可以直接在URL中定义，也可以通过`info`参数传递，这取决于提供页面的模块如果返回对应的UIViewController对象

```swift
guard let vc = ModuleManager.shared.viewController(withURL: "Question/Detail", info: ["questionID": "MyQuestionID"]) else {
  	return
}
// ...
```

> 除了可以通过ModuleManager来调用`viewController(withURL:, info:)`方法，也提供了Module中的便捷调用方法`Module.bus.viewController(withURL:, info:)`

在提供*问题详情页*的模块中，需要实现对应的**Module**的钩子方法

```swift
// Question模块
class QuestionModule: Module {
    
 		// 返回模块可以处理的URL
    override var canHandleURLs: [String]? {        
      	return [
          	"Question/Detail"
        ]
    }     
    
  	// 返回URL对应的ViewController
    override func viewController(withURL url: String, info: [String : Any]?) -> UIViewController? {       
      	// ...
      	if url == "Question/Detail", let questionID = info["questionID"] {
          	let questionDetailVC = QuestionDetailViewController(questionID: questionID)          
          	return questionDetailVC
        }      
        return nil
    }    
}
```



#### 通过Service调用相关服务

这里通过调用模拟的*登录*服务来举例

```swift
ModuleManager.shared.runService(withName: "User.SignIn",
																		info: ["account": "MyAccount",
																					 "password": "MyPassword"]) { (callbackParams) in
		// ...                                                                    
}
```

>  服务调用是异步进行

然后在*用户*模块中，需要对服务调用进行处理

```swift
// 用户模块
class MyModule: Module {    
    
  	// 返回模块可以处理服务名称
    override var canHandleServiceNames: [String]? {
        return ["User.SignIn"]
    }    
    
  	// 处理相关的服务调用
    override func runService(withName serviceName: String, info: [String : Any]?, callback: @escaping ([String : Any]) -> Void) -> Bool {        
      	if serviceName == "User.SignIn", let account = info["account"], let password = info["password"] {
          	// Sign In Handling ...
          	return true
				}
        return false
    }        
}
```



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



## LICENSE

此项目采用**MIT**开源协议，[点击查看详情](LICENSE)

