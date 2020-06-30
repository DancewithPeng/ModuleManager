# ObjCRuntime

对于**ObjC**运行时的相关封装

## 导入

```ruby
pod 'DPObjCRuntime', '~> 1.0'
```



## 使用

### MethodExchange

为方便使用，封装了方法交换的函数

```objective-c
// 实例方法交换
MethodExchange(self, @selector(...), @selector(...));
// 类方法交换
ClassMethodExchange(self, @selector(...), @selector(...));
```



## LICENSE

此项目采用**MIT**开源协议，[点击查看详情](LICENSE)

