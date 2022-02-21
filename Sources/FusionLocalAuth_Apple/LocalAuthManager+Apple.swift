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
    
   
    public func requestDeviceAuthentication(authTitle: String, reasonTitle: String, cancelTitle: String, completionStatus: @escaping (Bool, AuthError?) -> Void) {
        
        localAuthenticationContext.localizedFallbackTitle = authTitle
        localAuthenticationContext.localizedCancelTitle = cancelTitle
        
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonTitle) { success, evaluateError in
            
            if let error = evaluateError {
                completionStatus(false, self.getAuthError(errorCode: error._code))
            }
            completionStatus(success, nil)
            
        }
    }
    
   
    public func canAuthenticateWithBiometrics() -> Bool {
        var authorizationError: NSError?
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
            return true;
        }
        return false;
    }
    
    
    public func requestBiometricAuthentication(authTitle: String, reasonTitle: String, cancelTitle: String, completionStatus: @escaping (Bool, AuthError?) -> Void) {
        localAuthenticationContext.localizedFallbackTitle = authTitle
        localAuthenticationContext.localizedCancelTitle = cancelTitle
        
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonTitle) { success, evaluateError in
            
            if let error = evaluateError {
                completionStatus(false, self.getAuthError(errorCode: error._code))
            }
            completionStatus(success, nil)
        }
    }
    
    public func getAuthError(errorCode:Int) -> AuthError {
        switch errorCode {
        
        case LAError.userCancel.rawValue:
            return AuthError.AUTH_CANCELLED_USER
            
        case LAError.systemCancel.rawValue:
            return AuthError.AUTH_CANCELLED_SYSTEM
            
        case LAError.authenticationFailed.rawValue:
            return AuthError.AUTH_FAILED
            
        case LAError.notInteractive.rawValue:
            return  AuthError.AUTH_NOT_INTERACTIVE
            
        case LAError.userFallback.rawValue:
            return AuthError.BIOMETRY_DISCONNECTED
            
        case LAError.biometryLockout.rawValue:
            return AuthError.BIOMETRY_LOCKOUT
            
        case LAError.biometryNotAvailable.rawValue:
            return AuthError.BIOMETRY_NOT_AVAILABLE
            
        case LAError.biometryNotEnrolled.rawValue:
            return AuthError.BIOMETRY_NOT_ENROLLED
            
        case LAError.passcodeNotSet.rawValue:
            return AuthError.PASSCODE_NOT_SET
        default:
            return AuthError.LOCAL_AUTH_ERROR
        }
    }
}

#endif
