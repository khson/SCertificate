//
//  NPKI+Extension.swift
//  SCertificate
//
//  Created by KyuHo.Son on 16/08/2019.
//

import Foundation

extension NPKI {
    func getRootPath() -> URL {
        #if os(OSX)
        let libraryDir = try! fileManager.url(for: .libraryDirectory,
                                              in: .localDomainMask,
                                              appropriateFor: nil,
                                              create: true)
        return libraryDir.appendingPathComponent(NPKI.Preferences + "/" + NPKI.Root, isDirectory: true)
        #else
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return documentDir.appendingPathComponent(NPKI.Root, isDirectory: true)
        #endif
    }
    
    func getUrl(path: String) -> URL {
        #if os(OSX)
        let libraryDir = try! fileManager.url(for: .libraryDirectory,
                                              in: .localDomainMask,
                                              appropriateFor: nil,
                                              create: true)
        return libraryDir.appendingPathComponent(path, isDirectory: true)
        #else
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return documentDir.appendingPathComponent(path, isDirectory: true)
        #endif
    }
    
    func institutionsPath() -> [String] {
        var path = [String]()
        let upper = "USER"
        let lower = "User"
        institutions.forEach {
            path.append(String($0 + "/" + upper))
            path.append(String($0 + "/" + lower))
        }
        return path
    }
}
