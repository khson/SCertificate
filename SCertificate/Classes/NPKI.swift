//
//  NPKI.swift
//  SCertificate
//
//  Created by KyuHo.Son on 05/08/2019.
//

import Foundation

extension Certificate.NPKI {
    public func cleanUp() {
        let fileManager = FileManager.default
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        let rootPath = documentDir.appendingPathComponent(Certificate.NPKI.Root, isDirectory: true)
        institutions.forEach { cert in
            let certPath = rootPath.appendingPathComponent(cert, isDirectory: true)
            if fileManager.fileExists(atPath: certPath.path) {
                do {
                    let dirList = try fileManager.contentsOfDirectory(atPath: certPath.path)
                    dirList.forEach { dir in
                        let finalPath = certPath.appendingPathComponent(dir, isDirectory: true)
                        
                        let signDer = finalPath.appendingPathComponent(Certificate.NPKI.errorCertFile)
                        let signKey = finalPath.appendingPathComponent(Certificate.NPKI.errorKeyFile)
                        if fileManager.fileExists(atPath: signDer.path) &&
                            fileManager.fileExists(atPath: signKey.path) {
                            let orginSignDer = finalPath.appendingPathComponent(Certificate.NPKI.certFile)
                            let orginSignKey = finalPath.appendingPathComponent(Certificate.NPKI.keyFile)
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
    
    public func getList() -> [String] {
        var npkiList = [String]()
        
        let fileManager = FileManager.default
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        let rootPath = documentDir.appendingPathComponent(Certificate.NPKI.Root, isDirectory: true)
        institutions.forEach { cert in
            let certPath = rootPath.appendingPathComponent(cert, isDirectory: true)
            if fileManager.fileExists(atPath: certPath.path) {
                do {
                    let dirList = try fileManager.contentsOfDirectory(atPath: certPath.path)
                    dirList.forEach { dir in
                        let finalPath = certPath.appendingPathComponent(dir, isDirectory: true)
                        let signDer = finalPath.appendingPathComponent(Certificate.NPKI.certFile)
                        let signKey = finalPath.appendingPathComponent(Certificate.NPKI.keyFile)
                        
                        if fileManager.fileExists(atPath: signDer.path) &&
                            fileManager.fileExists(atPath: signKey.path) {
                            npkiList.append(String(Certificate.NPKI.Root + "/\(cert)/\(dir)"))
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
