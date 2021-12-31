//
//  LocalAuthManager.swift
//  
//
//  Created by VJ on 31/12/21.
//

import Foundation

public enum AuthError{
    
    case BIOMETRY_NOT_AVAILABLE
    case BIOMETRY_LOCKOUT
    case BIOMETRY_NOT_ENROLLED
    case BIOMETRY_DISCONNECTED
    
    case AUTH_CANCELLED_USER
    case AUTH_CANCELLED_SYSTEM
    case AUTH_FAILED
    
    case PASSCODE_NOT_SET
}


public protocol LocalAuthManagerProtocol {
    
    init()
    
    func canAuthenticateWithBiometrics() -> Bool
    
    func requestBiometricAuthentication() -> Void
    
    func requestDeviceAuthentication() -> Void
    
    func onAuthSuccess() -> Void
    
    func onAuthFailure(error: AuthError) -> Void
    
}
