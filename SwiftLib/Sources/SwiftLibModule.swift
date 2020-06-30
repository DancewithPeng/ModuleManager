//
//  SwiftLibModule.swift
//  SwiftLib
//
//  Created by 张鹏 on 2019/4/20.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import ModuleManager

class SwiftLibModule: Module {
    
    override var canHandleURLs: [String]? {
        return ["SwiftLib/SwiftLibViewController",
                "SwiftLib/SwiftLibViewController2"
        ]
    }
    
    override var canHandleServiceNames: [String]? {
        return ["sayHello"];
    }
    
    override func viewController(withURL url: String, info: [String : Any]?) -> UIViewController? {
        if url == "SwiftLib/SwiftLibViewController" || url == "SwiftLib/SwiftLibViewController2" {
            return SwiftLibViewController(nibName: "SwiftLibViewController", bundle: Bundle(for: SwiftLibModule.self))
        }
        
        return nil
    }
    
    override func runService(withName serviceName: String, info: [String : Any]?, callback: @escaping ([String : Any]) -> Void) -> Bool {
        guard serviceName == "sayHello" else {
            return false
        }
        
        guard let baseViewController = info?["baseViewController"] as? UIViewController else {
            return false
        }
        
        let alertController = UIAlertController(title: "这个是Swift Lib的提示", message: "Swift Lib", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        baseViewController.present(alertController, animated: true, completion: nil)
        
        callback([:])
        
        return true
    }
    
    override func willLoad() {
        print("Swift模块将要被加载...")
    }
    
    override func didLoad() {
        print("Swift模块已经被加载...")
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        print("\(#function) - \(application)")
    }
}
