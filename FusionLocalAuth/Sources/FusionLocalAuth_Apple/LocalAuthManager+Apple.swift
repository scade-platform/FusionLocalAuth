//
//  LocalAuthManager+Apple.swift
//  
//
//  Created by VJ on 31/12/21.
//

#if os(macOS) || os(iOS)

import Foundation
import FusionLocalAuth_Common

public class  LocalAuthManager: LocalAuthManagerProtocol {
    
    public required init() {}
    
    public func canAuthenticateWithBiometrics() -> Bool {
        return false
    }
    
    public func requestBiometricAuthentication(authTitle: String, reasonTitle: String, cancelText: String, status: @escaping (AuthError?) -> Void) {
        
    }
    
    public func requestDeviceAuthentication(authTitle: String, reasonTitle: String, cancelText: String, status: @escaping (AuthError?) -> Void) {
        
    }
    
    
}

#endif
