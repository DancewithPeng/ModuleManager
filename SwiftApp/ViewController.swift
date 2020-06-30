//
//  ViewController.swift
//  SwiftApp
//
//  Created by 张鹏 on 2019/4/20.
//  Copyright © 2019 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import ModuleManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func objCVCBtnDidClick(_ sender: Any) {
        let vc = Module.bus.viewController(withURL: "ObjCLib/ObjCLibViewController", info: nil)
        assert(vc != nil, "viewController(withURL:info:)返回的类型不正确")
        
        guard let nvc = vc else {
            return
        }
        navigationController?.pushViewController(nvc, animated: true)
    }
    
    @IBAction func swiftVCBtnDidClick(_ sender: Any) {
        let vc = Module.bus.viewController(withURL: "SwiftLib/SwiftLibViewController", info: nil)
        assert(vc != nil, "viewController(withURL:info:)返回的类型不正确")
        
        guard let nvc = vc else {
            return
        }
        navigationController?.pushViewController(nvc, animated: true)
    }
}

