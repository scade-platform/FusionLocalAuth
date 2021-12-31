# FusionLocalAuth

Another Fusion library to implement the local authentication using Biometry, or device password.

Features:

1.) detect whether the device has Biometry enabled or not


    ``` swift
            canAuthenticateWithBiometrics()
    ```


2.) request for only Biometry authentication (face auth or fingerprint)


    ``` swift
    
                requestBiometricAuthentication()
                
    ```

3.) request for Biometry authentication (face auth or fingerprint or pin/password)


    ``` swift
                    requestDeviceAuthentication()
    ```
    
3.) handle the callback for succesful/failed authentication

    ``` swift
                onAuthSuccess()
                onAuthFailure(error: AuthError)
    ```


