//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Maksim Kruglov on 15.02.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    let context = LAContext()
    let policy : LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    var error: NSError?

    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
       
        let result = context.canEvaluatePolicy(policy, error: &error)
        if result {
            context.evaluatePolicy(policy, localizedReason: "Verify your Identity") { result, error in
                authorizationFinished(result, error)
            }
        } else {
            authorizationFinished(false, self.error)
        }
        
    }
    
 
    func biometryTipeClarification() -> LABiometryType {
        let result = context.canEvaluatePolicy(policy, error: &error)
        
        if result {
            return context.biometryType
        }
        return LABiometryType.none
    }
    
}
