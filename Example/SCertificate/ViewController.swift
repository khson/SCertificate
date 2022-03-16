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
        certificateList.forEach() { certificate in
            let cert = npki.getCertFile(type: .signCertDer, path: certificate)
            //let pri = npki.getCertFile(type: .signPriKey, path: certificate)
            if let cert = cert {
                let info = getInfo(cert)
                print(info?.userName)
            }
        }
    }
    
    private func getInfo(_ cert: Data) -> Certificate.Info? {
        let certificate = Certificate.init(cert: cert)
        return certificate.getInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
