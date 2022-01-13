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
            
            if let error = evaluateError {
                switch error._code {
                case LAError.userCancel.rawValue:
                    status(false, .AUTH_CANCELLED_USER)
                    break
                case LAError.authenticationFailed.rawValue:
                    status(false, .AUTH_CANCELLED_SYSTEM)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .AUTH_FAILED)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .AUTH_NOT_INTERACTIVE)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_DISCONNECTED)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_LOCKOUT)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_NOT_AVAILABLE)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_NOT_ENROLLED)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .PASSCODE_NOT_SET)
                    break
                    
                default:
                    status(false, error as! AuthError)
                    break
                }
            }
            
            // successful deviceAuthentication
            if success {
                status(true, nil)
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
            
            if let error = evaluateError {
                switch error._code {
                case LAError.userCancel.rawValue:
                    status(false, .AUTH_CANCELLED_USER)
                    break
                case LAError.authenticationFailed.rawValue:
                    status(false, .AUTH_CANCELLED_SYSTEM)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .AUTH_FAILED)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .AUTH_NOT_INTERACTIVE)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_DISCONNECTED)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_LOCKOUT)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_NOT_AVAILABLE)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .BIOMETRY_NOT_ENROLLED)
                    break
                case LAError.userCancel.rawValue:
                    status(false, .PASSCODE_NOT_SET)
                    break
                    
                default:
                    status(false, error as! AuthError)
                    break
                }
            }
            if success {
                status(true, nil)
            }
        }
    }
}

#endif
