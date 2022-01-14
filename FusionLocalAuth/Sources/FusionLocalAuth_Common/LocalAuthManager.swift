//
//  LocalAuthManager.swift
//  
//
//  Created by VJ on 31/12/21.
//

import Foundation

public enum AuthError: Error{
    
    /*
     * @property BIOMETRY_NOT_AVAILABLE
     *
     * @discussion Biometry is not available in the device
     */
    case BIOMETRY_NOT_AVAILABLE
    
    /*
     * @property BIOMETRY_LOCKOUT
     *
     * @discussion Biometry is locked because there were too many failed attempts.
     */
    case BIOMETRY_LOCKOUT
    
    /*
     * @property BIOMETRY_NOT_ENROLLED
     *
     * @discussion The user has no enrolled biometric identities.
     */
    case BIOMETRY_NOT_ENROLLED
    
    /*
     * @property BIOMETRY_DISCONNECTED
     *
     * @discussion The device supports biometry only using a removable accessory, but the paired accessory isn’t connected.
     */
    case BIOMETRY_DISCONNECTED
    
    /*
     * @property AUTH_CANCELLED_USER
     *
     * @discussion The user tapped the cancel button in the authentication dialog.
     */
    case AUTH_CANCELLED_USER
    
    /*
     * @property AUTH_CANCELLED_SYSTEM
     *
     * @discussion The system canceled authentication.
     */
    case AUTH_CANCELLED_SYSTEM
    
    /*
     * @property AUTH_FAILED
     *
     * @discussion The user failed to provide valid credentials.
     */
    case AUTH_FAILED
    
    /*
     * @property AUTH_NOT_INTERACTIVE
     *
     * @discussion Displaying the required authentication user interface is forbidden.
     */
    case AUTH_NOT_INTERACTIVE
    
    /*
     * @property PASSCODE_NOT_SET
     *
     * @discussion A passcode isn’t set on the device.
     */
    case PASSCODE_NOT_SET
    
    public func description() -> String {
            switch self {
            
            case .BIOMETRY_NOT_AVAILABLE:
                return "Biometry is not available in the device."
                
            case .BIOMETRY_LOCKOUT:
                return "Biometry is locked because there were too many failed attempts."
                
            case .BIOMETRY_NOT_ENROLLED:
                return "The user has no enrolled biometric identities."
                
            case .BIOMETRY_DISCONNECTED:
                return "The device supports biometry only using a removable accessory, but the paired accessory isn’t connected."
                
            case .AUTH_CANCELLED_USER:
                return "The user tapped the cancel button in the authentication dialog."
                
            case .AUTH_CANCELLED_SYSTEM:
                return "The system canceled authentication."
                
            case .AUTH_FAILED:
                return "The user failed to provide valid credentials."
                
            case .AUTH_NOT_INTERACTIVE:
                return "Displaying the required authentication user interface is forbidden."
                
            case .PASSCODE_NOT_SET:
                return "A passcode isn’t set on the device."
            }
        }
    
}

@available(OSX 10.12.2, *)
public protocol LocalAuthManagerProtocol {
    
    init()
    
    /*
     * @property canAuthenticateWithBiometrics
     *
     * @discussion returns boolean if the biometric authentication is enabled in device or not
     *
     * @result Bool value
     */
    func canAuthenticateWithBiometrics() -> Bool
    
    /*
     * @property requestBiometricAuthentication
     *
     * @discussion requesets only biometric-authentication
     *
     * @param authTitle: String
     *        reasonTitle: String
     *        cancelText: String
     *
     */
    
    func requestBiometricAuthentication(authTitle:String, reasonTitle:String, cancelTitle:String, status: @escaping (Bool, AuthError?) -> Void )
    
    /*
     * @property requestDeviceAuthentication
     *
     * @discussion request biometry/pin/password authentication
     *
     * @param authTitle: String
     *        reasonTitle: String
     *        cancelText: String
     *
     */
    func requestDeviceAuthentication(authTitle:String, reasonTitle:String, cancelTitle:String, status: @escaping (Bool, AuthError?) -> Void)
    
}
