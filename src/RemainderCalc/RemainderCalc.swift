//
//  RemainderCalc.swift
//  RemainderCalc
//

import Foundation

/**
 - あまり割算計算マネージャー
 - Author: xinext HF
 - Copyright: xinext
 - Date: 2017/04/26
 - Version: 1.0.0
 */
class RemainderCalculationManager {

    // MARK: - private variable
    let MAX_INPUT_DIGITNUMBER = 12      // 最大入力桁数
    
    enum CalcState {
        case WAIT_DIVIDEND
        case WAIT_DIVISOR
        case DISP_ANSWER
    }
    
    var _calcState: CalcState
    
    let DispDecPosStrings: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "F"]
    private var _decPos: Int        // 小数点位置
    private var _dividend: String   // 割られる数
    private var _divisor: String    // 割る数
    
    // MARK: - public variable
    /**
     [Property]小数点位置
     */
    var P_DecPosString: String {
        get {
            return DispDecPosStrings[self._decPos]
        }
    }
    
    /**
     [Property]入力値
     */
    var P_InputValuesString: String {
        get {
            switch _calcState {
            case .WAIT_DIVIDEND:
                return _dividend
            case .WAIT_DIVISOR:
                return _divisor
            default:
                return ""
            }
        }
    }
    
    /**
     [Property]答え
     */
    var P_AnswerString: String {
        get {
            return getAnswerString()
        }
    }
    
    /**
     [Property]式
     */
    var P_ExpressionString: String {
        get {
            return getExpressionString()
        }
    }
    
    /**
     [Property]割られる値
     */
    var P_DividendValue: NSDecimalNumber {
        get {
            // 割られる値を取得
            let decDividend = NSDecimalNumber(string: self._dividend)
            if (decDividend.decimalValue.isNaN) {   // error
                return NSDecimalNumber(string: "0.0")
            }
            
            return decDividend
        }
    }
    
    /**
     [Property]割る値
     */
    var P_DivisorValue: NSDecimalNumber {
        get {
            // 割られる値を取得
            let decDivisor = NSDecimalNumber(string: self._divisor)
            if (decDivisor.decimalValue.isNaN) {   // error
                return NSDecimalNumber(string: "0.0")
            }
            
            return decDivisor
        }
    }

    /**
     [Property]小数点位置
     */
    var P_DecimalPosition: Int {
        get {
            return self._decPos
        }
    }
    
    
    // MARK: - Initializer
    /**
     Initializer
     */
    init() {
        self._calcState = .WAIT_DIVIDEND
        self._dividend = ""
        self._divisor = ""

        self._decPos = 0
    }
    
    // MARK: - public method
    /**
     計算に関連する値のみ初期化する。
     (without decimal position)
     */
    func InitValuesForCalc() {
        self._calcState = .WAIT_DIVIDEND
        self._dividend = ""
        self._divisor = ""
    }
    
    /**
     小数点位置を１大きくする
     最大を超える場合は無視する
     */
    func UpDecimalPosition() {
        if ( _decPos < (DispDecPosStrings.count-1) ) {
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
    
    /**
     小数点位置を設定
     設定範囲外になる場合は0とする
     */
    func SetDecimalPosition(_ dp: Int) {
        
        if ( (_decPos >= 0) && (_decPos <= (DispDecPosStrings.count-1)) ) {
            _decPos = dp
        }
        else {
            _decPos = 0
        }
    }
    
    /**
     計算値の初期化
     */
    func ExecuteAllClear() {
        initEachItemForDisp()
    }
    
    /**
     一つ戻る
     */
    func ExecuteBackSpace() {
        
        switch self._calcState {
        case .WAIT_DIVIDEND:
            self._dividend = subBackSpace(self._dividend)
            
        case .WAIT_DIVISOR:
            self._divisor = subBackSpace(self._divisor)
            
        default:    // DISP_ANSWER
            // No Action
            break;
        }
    }
    
    /**
     値の入力
     ex:(0-9ボタン押下等)
     */
    func InputNumber(_ value: Int) {
        
        // 入力値チェック(期待しない値は無視する)
        if !(value >= 0 && value <= 9) {    // 範囲チェック
            return
        }
        
        // 値のセット
        switch self._calcState {
        case .WAIT_DIVIDEND:
            
            if (!(value == 0 && self._dividend.count <= 0) &&        // 先頭値チェック
                (self._dividend.count < MAX_INPUT_DIGITNUMBER)) {    // リミットチェック
                self._dividend.append(String(value))
            }
            else {
                // 入力不可時は場合は無視する
            }
            
        case .WAIT_DIVISOR:

            if (!(value == 0 && self._divisor.count <= 0) &&         // 先頭値チェック
                (self._divisor.count < MAX_INPUT_DIGITNUMBER)) {     // リミットチェック
                self._divisor.append(String(value))
            }
            else {
                // 入力不可時は場合は無視する
            }
            
        default:    // DISP_ANSWER
            // No Action
            break;
        }
    }
    
    /**
     小数点の入力
     ex:(.ボタン押下)
     */
    func InputDecimalPoint() {
        
        // 値のセット
        switch self._calcState {
        case .WAIT_DIVIDEND:
            
            checkInputValueForDecimalPoint(value: &self._dividend)
            
        case .WAIT_DIVISOR:
            
            checkInputValueForDecimalPoint(value: &self._divisor)
            
        default:    // DISP_ANSWER
            // No Action
            break;
        }
    }
    
    /**
     割られる値の確定
     ex:(÷ボタン押下等)
     */
    func DecideDividend() {
        
        self._calcState = .WAIT_DIVISOR
    }
    
    /**
     割る値の確定
     ex:(=ボタン押下等)
     */
    func DecideDiviSor() {
        
        self._calcState = .DISP_ANSWER
    }
    
    // MARK: - private method
    private func initEachItemForDisp() {
        
        self._calcState = .WAIT_DIVIDEND
        self._dividend = ""
        self._divisor = ""
    }
    
    /**
     最後の数字or小数点を削除
     ExecuteBackSpaceのサブ関数
     */
    private func subBackSpace(_ inputString: String ) -> String {
        
        var outString: String = ""
        
        if (inputString.count > 0) {
            
            // １文字削る
            let offset = inputString.count - 1
            outString = String(inputString[..<inputString.index(inputString.startIndex, offsetBy: offset)])

            // 削った結果が0の場合は、空白とする
            let tmpValue = NSDecimalNumber(string: outString)
            if (tmpValue.decimalValue.isNaN != true) {
                if (tmpValue.decimalValue <= 0) {
                    outString = ""
                }
                else {
                    // no action
                }
            }
            else {  // 数値化に失敗した場合(イリーガル処理)
                outString = ""
            }
        }
        else{
            // 数値が無い場合は、何もしない
        }
        
        return outString
    }
    
    /**
     小数点入力チェック
     InputDecimalPointのサブ関数
     */
    func checkInputValueForDecimalPoint( value: inout String) {
        
        if (value.contains(".") == false) {    // ２つ目の小数点チェック
            if (value.count <= 0) { // 先頭チェック
                value.append("0.")
            }
            else if ((value.count > 0) &&
                (value.count <= (MAX_INPUT_DIGITNUMBER-2))) {   // リミットチェック
                value.append(".")
            }
            else {
                // 入力不可時は場合は無視する
            }
        }
        else {
            // 入力不可時は場合は無視する
        }
    }
    
    /**
     式テキストを取得
     */
    func getExpressionString() -> String {
        
        var resString = ""
        // 小数点以下がない場合はカット
        var dividendString = _dividend
        if ( dividendString.suffix(1) == "." ) {
            dividendString = String(dividendString.prefix(_dividend.count-1))
        }

        var divisorString = _divisor
        if ( divisorString.suffix(1) == "." ) {
            divisorString = String(_divisor.prefix(_divisor.count-1))
        }
        
        // 式の作成
        switch self._calcState {
        case .WAIT_DIVISOR:
            resString = dividendString + "÷"
        case .DISP_ANSWER:
            resString = dividendString + "÷" + divisorString
        default:    // WAIT_DIVIDEND
            resString = ""
            break;
        }
        
        return resString
    }
    
    /**
     答えテキストを取得
     */
    private func getAnswerString() -> String {
        
        var resString = ""
        
        if ( self._calcState == .DISP_ANSWER ) {
            
            // 割られる値を取得
            let decDividend = NSDecimalNumber(string: self._dividend)
            if (decDividend.decimalValue.isNaN) {
                return NSLocalizedString("STR_MAIN_ANSWER_ERROR_TEXT", comment: "")
            }
            
            // 割る値を取得
            let decDivisor = NSDecimalNumber(string: self._divisor)
            if (decDivisor.decimalValue.isNaN) {
                return NSLocalizedString("STR_MAIN_ANSWER_ERROR_TEXT", comment: "")
            }
            
            // 割り算計算
            var decAnswer: NSDecimalNumber
            var decRemainder = NSDecimalNumber(string: "0")
            
            if ( NSDecimalNumber(string: P_DecPosString).decimalValue.isNaN) {    // 余りFree
                decAnswer = decDividend.dividing(by: decDivisor)
                if (decAnswer.decimalValue.isNaN) {
                    return NSLocalizedString("STR_MAIN_ANSWER_ERROR_TEXT", comment: "")
                }
            }
            else {
                
                // 商を求める
                decAnswer = decDividend.dividing(by: decDivisor, withBehavior: NSDecimalNumberHandler(roundingMode: .down,
                                                                                                      scale: Int16(self._decPos),
                                                                                                      raiseOnExactness: false,
                                                                                                      raiseOnOverflow: false,
                                                                                                      raiseOnUnderflow: false,
                                                                                                      raiseOnDivideByZero: false) )
                if (decAnswer.decimalValue.isNaN) {
                    return NSLocalizedString("STR_MAIN_ANSWER_ERROR_TEXT", comment: "")
                }
                
                // 余りを求める
                let workValue = decAnswer.multiplying(by: decDivisor)
                decRemainder = decDividend.subtracting(workValue)
            }
            
            // 答えテキストを生成
            resString = decAnswer.stringValue
            if (decRemainder.decimalValue > 0) {
                resString += NSLocalizedString("STR_APP_MARK_REMAINDER", comment: "R")
                resString += decRemainder.stringValue
            }
            
        }
        else {
            resString = ""
        }
        
        return resString
    }
}
