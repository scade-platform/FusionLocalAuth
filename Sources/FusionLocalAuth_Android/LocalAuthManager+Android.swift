//
//  LocalAuthManager+Android.swift
//
//
//  Created by VJ on 31/12/21.
//

import Android
import AndroidApp
import AndroidContent
import AndroidOS
import Foundation
import FusionLocalAuth_Common

public class LocalAuthManager: LocalAuthManagerProtocol {

  typealias AndroidKeyguardManager = AndroidApp.KeyguardManager
  typealias AndroidActivity = AndroidApp.Activity

  private var currentActivity: Activity? { Application.currentActivity }
  private let androidKeyguardManager: AndroidKeyguardManager?

  public required init() {
    self.androidKeyguardManager =
      Application.currentActivity?.getSystemService(name: ContextStatic.KEYGUARD_SERVICE)
      as? AndroidKeyguardManager
  }

  public func requestDeviceAuthentication(
    authTitle: String, reasonTitle: String, cancelTitle: String,
    completionStatus: @escaping (Bool, AuthError?) -> Void
  ) {
    if androidKeyguardManager == nil {
      print("androidKeyguardManager is null")
      return
    }

    if androidKeyguardManager!.isKeyguardSecure() {
      print("keyguard is secure.")
      let authIntent = androidKeyguardManager!.createConfirmDeviceCredentialIntent(
        title: "title", description: "desc")
      currentActivity!.startActivityForResult(intent: authIntent, requestCode: 333)
    }

  }

  public func canAuthenticateWithBiometrics() -> Bool {
    if androidKeyguardManager != nil {
      print("android keyguardmanager")
      return androidKeyguardManager!.isDeviceSecure()
    }
    print("android keyguard manager is null")
    return false
  }

  public func requestBiometricAuthentication(
    authTitle: String, reasonTitle: String, cancelTitle: String,
    completionStatus: @escaping (Bool, AuthError?) -> Void
  ) {
    print("Biometric authentication now available in SCADE platform as of now!")
  }

}
