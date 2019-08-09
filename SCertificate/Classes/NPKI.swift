//
//  NPKI.swift
//  SCertificate
//
//  Created by KyuHo.Son on 05/08/2019.
//

import Foundation

public struct NPKI: Certificate {
    public enum CertificateType {
        case signCertDer
        case signPriKey
        
        var fileName: String {
            switch self {
            case .signCertDer: return NPKI.certFile
            case .signPriKey: return NPKI.keyFile
            }
        }
    }
    static let Root = "NPKI"
    static let certFile = "signCert.der"
    static let keyFile = "signPri.key"
    static let errorCertFile = "SignCert.der"
    static let errorKeyFile = "SignPri.key"
    let fileManager = FileManager.default
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

extension NPKI {
    private func getRootPath() -> URL {
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return documentDir.appendingPathComponent(NPKI.Root, isDirectory: true)
    }
    
    private func getUrl(path: String) -> URL {
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return documentDir.appendingPathComponent(path, isDirectory: true)
    }
}

extension NPKI {
    public func cleanUp() {
        let rootPath = getRootPath()
        
        institutions.forEach { cert in
            let certPath = rootPath.appendingPathComponent(cert, isDirectory: true)
            if fileManager.fileExists(atPath: certPath.path) {
                do {
                    let dirList = try fileManager.contentsOfDirectory(atPath: certPath.path)
                    dirList.forEach { dir in
                        let finalPath = certPath.appendingPathComponent(dir, isDirectory: true)
                        
                        let signDer = finalPath.appendingPathComponent(NPKI.errorCertFile)
                        let signKey = finalPath.appendingPathComponent(NPKI.errorKeyFile)
                        if fileManager.fileExists(atPath: signDer.path) &&
                            fileManager.fileExists(atPath: signKey.path) {
                            let orginSignDer = finalPath.appendingPathComponent(NPKI.certFile)
                            let orginSignKey = finalPath.appendingPathComponent(NPKI.keyFile)
                            do {
                                _ = try fileManager.moveItem(at: signDer, to: orginSignDer)
                                _ = try fileManager.moveItem(at: signKey, to: orginSignKey)
                            } catch {
                                print("error")
                            }
                            
                        }
                    }
                } catch {
                    print("error")
                }
            }
        }
    }
}

extension NPKI {
    public func getList() -> [String] {
        var npkiList = [String]()
        let rootPath = getRootPath()
        
        institutions.forEach { cert in
            let certPath = rootPath.appendingPathComponent(cert, isDirectory: true)
            if fileManager.fileExists(atPath: certPath.path) {
                do {
                    let dirList = try fileManager.contentsOfDirectory(atPath: certPath.path)
                    dirList.forEach { dir in
                        let finalPath = certPath.appendingPathComponent(dir, isDirectory: true)
                        let signDer = finalPath.appendingPathComponent(NPKI.certFile)
                        let signKey = finalPath.appendingPathComponent(NPKI.keyFile)
                        
                        if fileManager.fileExists(atPath: signDer.path) &&
                            fileManager.fileExists(atPath: signKey.path) {
                            npkiList.append(String(NPKI.Root + "/\(cert)/\(dir)"))
                        }
                    }
                } catch {
                    print("error")
                }
            }
        }
        return npkiList
    }
}

extension NPKI {
    public func getCertFile(type: CertificateType, path: String) -> Data? {
        do {
            return try Data.init(contentsOf: getUrl(path: String(path + "/" + type.fileName)))
        } catch {
            return nil
        }
    }
}
