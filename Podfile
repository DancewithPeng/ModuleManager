platform :ios, '10.0'                # 指定平台和最低版本
inhibit_all_warnings!               # 无视所有警告
use_frameworks!                     # 使用framework代替静态库

pod 'DPMessageBus', '~> 1.0.0'
pod 'DPLog', '~> 2.0.0'
pod 'DPObjCRuntime', '~> 1.0.0'

target 'ModuleManager' do					# target 对应Xcode中的target

end

target 'ObjCApp' do					# target 对应Xcode中的target

end

target 'SwiftApp' do          # target 对应Xcode中的target
  
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		puts target.name
	end
end
