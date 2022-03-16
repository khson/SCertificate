//
//  Certificate.swift
//  SCertificate
//
//  Created by KyuHo.Son on 2022/03/16.
//

import Foundation

public class Certificate: SCertificate {
    public struct Info {
        public var version: Int?
        public var serialNumber: Data?
        public var issuerDistinguishedName: String?
        public var issuerOIDs: [String] = []
        public var subjectDistinguishedName: String?
        public var userName: String?
        public var subjectOIDs: [String] = []
        public var notBefore: Date?
        public var notAfter: Date?
        public var signature: Data?
        public var sigAlgName: String?
        public var sigAlgOID: String?
        public var sigAlgParams: Data?
        public var keyUsage: [Bool] = []
        public var extendedKeyUsage: [String] = []
        public var subjectAlternativeNames: [String] = []
        public var issuerAlternativeNames: [String] = []
        public var criticalExtensionOIDs: [String] = []
        public var nonCriticalExtensionOIDs: [String] = []
    }
        
    public init(cert: Data) {
        self.cert = cert
    }
    
    private var x509: X509Certificate?
    private var cert: Data
    
    public func getInfo() -> Certificate.Info? {
        do {
            self.x509 = try X509Certificate(data: cert)
            guard let x509 = x509 else {
                return nil
            }
            var info = Info.init()
            info.version = x509.version
            info.serialNumber = x509.serialNumber
            info.issuerDistinguishedName = x509.issuerDistinguishedName
            info.issuerOIDs = x509.issuerOIDs
            info.subjectDistinguishedName = x509.subjectDistinguishedName
            info.userName = x509.userName
            info.subjectOIDs = x509.subjectOIDs
            info.notBefore = x509.notBefore
            info.notAfter = x509.notAfter
            info.signature = x509.signature
            info.sigAlgName = x509.sigAlgName
            info.sigAlgOID = x509.sigAlgOID
            info.sigAlgParams = x509.sigAlgParams
            info.keyUsage = x509.keyUsage
            info.extendedKeyUsage = x509.extendedKeyUsage
            info.subjectAlternativeNames = x509.subjectAlternativeNames
            info.issuerAlternativeNames = x509.issuerAlternativeNames
            info.criticalExtensionOIDs = x509.criticalExtensionOIDs
            info.nonCriticalExtensionOIDs = x509.nonCriticalExtensionOIDs
            return info
        } catch {
            print("error")
        }
        return nil
    }
    
    public func issuer(oid: String) -> String? {
        guard let x509 = x509 else {
            return nil
        }
        return x509.issuer(oid: oid)
    }
    
    public func subject(oid: String) -> String? {
        guard let x509 = x509 else {
            return nil
        }
        return x509.subject(oid: oid)
    }
}
