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
            }
            let authError = self.getAuthError(error: evaluateError!)
            status(false, authError)
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
            }
            let authError = self.getAuthError(error: evaluateError!)
            status(false, authError)
        }
    }
    
    public func getAuthError(error:Error) -> AuthError {
        switch error._code {
        
        case LAError.userCancel.rawValue:
            return .AUTH_CANCELLED_USER
            
        case LAError.authenticationFailed.rawValue:
            return .AUTH_CANCELLED_SYSTEM
            
        case LAError.userCancel.rawValue:
            return .AUTH_FAILED
            
        case LAError.userCancel.rawValue:
            return  .AUTH_NOT_INTERACTIVE
            
        case LAError.userCancel.rawValue:
            return .BIOMETRY_DISCONNECTED
            
        case LAError.userCancel.rawValue:
            return .BIOMETRY_LOCKOUT
            
        case LAError.userCancel.rawValue:
            return .BIOMETRY_NOT_AVAILABLE
            
        case LAError.userCancel.rawValue:
            return .BIOMETRY_NOT_ENROLLED
            
        case LAError.userCancel.rawValue:
            return .PASSCODE_NOT_SET
            
        default:
            return error as! AuthError
        }
        
    }
}

#endif
