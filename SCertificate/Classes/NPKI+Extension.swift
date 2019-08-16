//
//  NPKI+Extension.swift
//  SCertificate
//
//  Created by KyuHo.Son on 16/08/2019.
//

import Foundation

extension NPKI {
    func getRootPath() -> URL {
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return documentDir.appendingPathComponent(NPKI.Root, isDirectory: true)
    }
    
    func getUrl(path: String) -> URL {
        // swiftlint:disable:next force_try
        let documentDir = try! fileManager.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: true)
        return documentDir.appendingPathComponent(path, isDirectory: true)
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
