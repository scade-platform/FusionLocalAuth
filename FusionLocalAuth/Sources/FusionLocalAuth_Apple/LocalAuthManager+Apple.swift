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

@available(OSX 10.12.2, *)
public class  LocalAuthManager: LocalAuthManagerProtocol {
    
    let localAuthenticationContext = LAContext()
    public required init() {}
    
   
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
    
   
    public func canAuthenticateWithBiometrics() -> Bool {
        var authorizationError: NSError?
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
            return true;
        }
        return false;
    }
    
    
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
            
        case LAError.systemCancel.rawValue:
            return .AUTH_CANCELLED_SYSTEM
            
        case LAError.authenticationFailed.rawValue:
            return .AUTH_FAILED
            
        case LAError.notInteractive.rawValue:
            return  .AUTH_NOT_INTERACTIVE
            
        case LAError.userFallback.rawValue:
            return .BIOMETRY_DISCONNECTED
            
        case LAError.biometryLockout.rawValue:
            return .BIOMETRY_LOCKOUT
            
        case LAError.biometryNotAvailable.rawValue:
            return .BIOMETRY_NOT_AVAILABLE
            
        case LAError.biometryNotEnrolled.rawValue:
            return .BIOMETRY_NOT_ENROLLED
            
        case LAError.passcodeNotSet.rawValue:
            return .PASSCODE_NOT_SET
            
        default:
            return error as! AuthError
        }
    }
}

#endif
