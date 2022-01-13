//
//  LocalAuthManager+Apple.swift
//  
//
//  Created by VJ on 31/12/21.
//

#if os(macOS) || os(iOS)

import Foundation
import FusionLocalAuth_Common
import LocalAuthentication


public class  LocalAuthManager: LocalAuthManagerProtocol {
    
    let localAuthenticationContext = LAContext()
    public required init() {}
    
    @available(OSX 10.12.2, *)
    public func requestDeviceAuthentication(authTitle: String, reasonTitle: String, cancelTitle: String, status: @escaping (Bool, AuthError?) -> Void) {
        
        localAuthenticationContext.localizedFallbackTitle = authTitle
        localAuthenticationContext.localizedCancelTitle = cancelTitle
        
        
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonTitle) { success, evaluateError in
            if success {
                status(true, nil)
            } else {
                status(false, (evaluateError as? AuthError))
            }
        }
    }
    
    
    
    @available(OSX 10.12.2, *)
    public func canAuthenticateWithBiometrics() -> Bool {
        var authorizationError: NSError?
        
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
            return true;
        }
        
        return false;
    }
    
    @available(OSX 10.12.2, *)
    public func requestBiometricAuthentication(authTitle: String, reasonTitle: String, cancelTitle: String, status: @escaping (Bool, AuthError?) -> Void) {
        localAuthenticationContext.localizedFallbackTitle = authTitle
        localAuthenticationContext.localizedCancelTitle = cancelTitle
        
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonTitle) { success, evaluateError in
            if success {
                status(true, nil)
            } else {
                status(false, (evaluateError as? AuthError))
            }
        }
    }
}

#endif
