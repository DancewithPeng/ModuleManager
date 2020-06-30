//
//  SwiftLibViewController.swift
//  SwiftLib
//
//  Created by 张鹏 on 2019/4/20.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit

class SwiftLibViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftLibModule.bus.runService(withName: "User/SignIn",
                                      info: ["account": "MyAccount",
                                             "password": "MyPassword"]) { (info) in
            
        }
    }
    
    @IBAction func pushObjCViewControllerButtonDidClick(_ sender: Any) {
        let vc = SwiftLibModule.bus.viewController(withURL: "ObjCLib/ObjCLibViewController2", info: nil)
        assert(vc != nil, "viewController(withURL:info:)返回的类型不正确")
        
        guard let nvc = vc else {
            return
        }
        navigationController?.pushViewController(nvc, animated: true)
    }
}
