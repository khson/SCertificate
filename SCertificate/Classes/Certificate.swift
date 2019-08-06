//
//  Certificate.swift
//  SCertificate
//
//  Created by KyuHo.Son on 05/08/2019.
//

import Foundation

public enum Certificate {
    public struct NPKI {
        static let Root = "NPKI"
        static let certFile = "signCert.der"
        static let keyFile = "signPri.key"
        static let errorCertFile = "SignCert.der"
        static let errorKeyFile = "SignPri.key"
        let institutions = [
            "CrossCert/USER",
            "CrossCert/User",
            "KICA/USER",
            "KICA/User",
            "KISA/USER",
            "KISA/User",
            "NCASign/USER",
            "NCASign/User",
            "SignKorea/USER",
            "SignKorea/User",
            "TradeSign/USER",
            "TradeSign/User",
            "yessign/USER",
            "yessign/User"
        ]
        
        public init() {
            cleanUp()
        }
    }
}

