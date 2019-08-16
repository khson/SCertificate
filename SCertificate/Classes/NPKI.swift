//
//  NPKI.swift
//  SCertificate
//
//  Created by KyuHo.Son on 05/08/2019.
//

import Foundation

public struct NPKI: SCertificate {
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
    private static let certFile = "signCert.der"
    private static let keyFile = "signPri.key"
    private static let errorCertFile = "SignCert.der"
    private static let errorKeyFile = "SignPri.key"
    let institutions = ["CrossCert", "KICA", "KISA", "NCASign", "SignKorea", "TradeSign", "yessign"]
    
    let fileManager = FileManager.default
    
    public init() {
        cleanUp()
    }
}

extension NPKI {
    public mutating func cleanUp() {
        let rootPath = getRootPath()
        institutionsPath().forEach { cert in
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
    public mutating func getList() -> [String] {
        var npkiList = [String]()
        let rootPath = getRootPath()
        
        institutionsPath().forEach { cert in
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
