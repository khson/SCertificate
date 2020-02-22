//
//  ViewController.swift
//  SCertificate
//
//  Created by khson on 08/04/2019.
//  Copyright (c) 2019 khson. All rights reserved.
//

import UIKit
import SCertificate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let npki = NPKI.init()
        let certificateList = npki.getList()
        print(certificateList)
        
        certificateList.forEach()
        let cert = npki.getCertFile(type: .signCertDer, path: certificateList[0])
        let pri = npki.getCertFile(type: .signPriKey, path: certificateList[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
