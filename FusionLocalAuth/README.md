# FusionLocalAuth

Another Fusion library to implement the local authentication using Biometry, or device password. It is fully compatible cross-platform for iOS and Android.

Features:

1.) detect whether the device has Biometry enabled or not


    
            canAuthenticateWithBiometrics()
   


2.) request for only Biometry authentication (face auth or fingerprint)


    
    
                requestBiometricAuthentication()
  
                
    
3.) request for Biometry authentication (face auth or fingerprint or pin/password)


   
                    requestDeviceAuthentication()

   
    
3.) handle the callback for succesful/failed authentication

    
                onAuthSuccess()
                onAuthFailure(error: AuthError)
    

