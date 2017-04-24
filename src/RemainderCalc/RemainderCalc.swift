//
//  RemainderCalc.swift
//  RemainderCalc
//

import Foundation

/**
 - あまり割算計算マネージャー
 - Author: xinext HF
 - Copyright: xinext
 - Date: 2017/04/24
 - Version: 1.0.0
 */
class RemainderCalculationManager {

    // MARK: - private variable
    let DispStrings: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "F"]
    
    private var _decPos: Int
    
    // MARK: - public variable
    var DecPosString: String {
        get {
            return DispStrings[self._decPos]
        }
    }
    
    // MARK: - Initializer
    /**
     Initializer
     */
    init() {
        _decPos = 0
    }
    
    // MARK: - public method
    /**
     小数点位置を１大きくする
     最大を超える場合は無視する
     */
    func UpDecimalPosition() {
        if ( _decPos < (DispStrings.count-1) ) {
            _decPos += 1
        }
    }
    
    /**
     小数点位置を１小さくする
     0未満になる場合は無視する
     */
    func DownDecimalPosition() {
        
        if ( _decPos > 0 ) {
            _decPos -= 1
        }
    }
}
