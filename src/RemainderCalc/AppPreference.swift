//
//  AppPreference.swift
//  For RemainderCalc
//

import Foundation
import UIKit

/**
 - アプリケーション共通設定
 - Author: xinext
 - Copyright: xinext
 - Date: 2017/08/14
 - Version: 1.0.0
 */
class AppPreference {
    
    // MARK: - Parameter keys
    enum Keys: String {
        case DecimalPoint = "DecimalPoint"
        case ButtonPushedSound = "ButtonPushedSound"
    }
   
    // MARK: - For all parameter
    /**
     Save all parameters.
     */
    func SaveAllParameters() {
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - For DecimalPoint
    static let DEF_DECIMAL_POINT: Int = 0

    /**
     Set parameter of DecimalPoint.
     - parameter value: DecimalPoint value.
     */
    static func SetDecimalPoint(value: Int) {
        UserDefaults.standard.set(value, forKey: Keys.DecimalPoint.rawValue)
    }
    
    /**
     Get parameter of DecimalPoint.
     - returns: DecimalPoint value.
     */
    static func GetDecimalPoint() -> Int {
        
        var value: Int? = UserDefaults.standard.object(forKey: Keys.DecimalPoint.rawValue) as! Int?
        if ( value != nil ) {
            // Data is OK
        }
        else {
            self.SetDecimalPoint(value: AppPreference.DEF_DECIMAL_POINT)
            value = AppPreference.DEF_DECIMAL_POINT
        }
        
        return value!
    }
    
    // MARK: - For ButtonPushedSound
    static let DEF_BUTTON_PUSHED_SOUND: Bool = false
    
    /**
     Set parameter of ButtonPushedSound.
     - parameter value: ButtonPushedSound value.
     */
    static func SetButtonPushedSound(value: Bool) {
        UserDefaults.standard.set(value, forKey: Keys.ButtonPushedSound.rawValue)
    }
    
    /**
     Get parameter of ButtonPushedSound.
     - returns: ButtonPushedSound value.
     */
    static func GetButtonPushedSound() -> Bool {
        
        var value: Bool? = UserDefaults.standard.object(forKey: Keys.ButtonPushedSound.rawValue) as! Bool?
        if ( value != nil ) {
            // Data is OK
        }
        else {
            self.SetButtonPushedSound(value: AppPreference.DEF_BUTTON_PUSHED_SOUND)
            value = AppPreference.DEF_BUTTON_PUSHED_SOUND
        }
        
        return value!
    }
}
