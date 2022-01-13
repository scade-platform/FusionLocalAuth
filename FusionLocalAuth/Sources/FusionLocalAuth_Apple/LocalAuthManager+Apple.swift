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
        
        
        
        func requestAuth(fallbackTitle:String, cancelTitle:String, reasonTitle: String) {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = fallbackTitle
            
            if #available(OSX 10.12, *) {
                localAuthenticationContext.localizedCancelTitle = cancelTitle
            } else {
                // Fallback on earlier versions
            }
            
            var authorizationError: NSError?
            if #available(OSX 10.12, *) {
            } else {
                // Fallback on earlier versions
            }
            
            
            if #available(OSX 10.12.2, *) {
                if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
                    
                    localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonTitle) { success, evaluateError in
                        if success {
                            
                        } else {
                            
                            //self.delegate?.onFailure(error: evaluateError as! LAError)
                            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonTitle) { success, evaluateError in
                                
                                if success {
                                    //
                                    
                                    
                                } else {
                                    
                                    /*
                                     if(evaluateError.code == 1)
                                     self.delegate?.onFailure(error: .ERROR1)
                                     */
                                    
                                }
                            }
                        }
                    }
                } else {
                    
                    //            guard let error = authorizationError else {
                    //                return
                    //            }
                    //self.delegate?.onFailure(error: authorizationError as! LAError)
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
        
    }
}

#endif
