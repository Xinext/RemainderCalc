//
//  MainViewController.swift
//  RemainderCalc
//


import UIKit
import AVFoundation

class MainViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var outletMainContentsView: UIView!
    @IBOutlet weak var outletMainContentsBottomLayoutConstraint: NSLayoutConstraint!
    
    // タイトルエリア
    @IBOutlet weak var outletNavigationItem: UINavigationItem!  // アプリタイトル
    @IBOutlet weak var outletHistoryButton: UIBarButtonItem!    // 履歴ボタン
    @IBOutlet weak var outletPreferenceButton: UIBarButtonItem! // 設定ボタン
    
    // 表示エリア
    @IBOutlet weak var outletInputValueLabel: XIPaddingLabel!           // 入力値テキストラベル
    @IBOutlet weak var outletExpressionLabel: XIPaddingLabel!           // 式タイトルラベル
    @IBOutlet weak var outletExpressionValueLabel: XIPaddingLabel!      // 式テキストラベル
    @IBOutlet weak var outletAnswerLabel: XIPaddingLabel!               // 答えタイトルラベル
    @IBOutlet weak var outletAnswerValueLabel: XIPaddingLabel!          // 答えテキストラベル
    @IBOutlet weak var outletDecimalPointTitleLabel: XIPaddingLabel!    // 小数点位置タイトルラベル
    @IBOutlet weak var outletDecimalPointDownButton: XIPaddingButton!   // 小数点Downボタン
    @IBOutlet weak var outletDecimalPointValueLabel: XIPaddingLabel!    // 小数点位置テキスト
    @IBOutlet weak var outletDecimalPointUpButton: XIPaddingButton!     // 小数点Upボタン
    
    // 入力エリア
    @IBOutlet weak var outletKey0Button: XIPaddingButton!               // 0キーボタン
    @IBOutlet weak var outletKey00Button: XIPaddingButton!              // 00キーボタン
    @IBOutlet weak var outletKey1Button: XIPaddingButton!               // 1キーボタン
    @IBOutlet weak var outletKey2Button: XIPaddingButton!               // 2キーボタン
    @IBOutlet weak var outletKey3Button: XIPaddingButton!               // 3キーボタン
    @IBOutlet weak var outletKey4Button: XIPaddingButton!               // 4キーボタン
    @IBOutlet weak var outletKey5Button: XIPaddingButton!               // 5キーボタン
    @IBOutlet weak var outletKey6Button: XIPaddingButton!               // 6キーボタン
    @IBOutlet weak var outletKey7Button: XIPaddingButton!               // 7キーボタン
    @IBOutlet weak var outletKey8Button: XIPaddingButton!               // 8キーボタン
    @IBOutlet weak var outletKey9Button: XIPaddingButton!               // 9キーボタン
    @IBOutlet weak var outletKeyDotButton: XIPaddingButton!             // 小数点キーボタン
    @IBOutlet weak var outletKeyACButton: XIPaddingButton!              // AC(All Clear)キーボタン
    @IBOutlet weak var outletKeyBSButton: XIPaddingButton!              // BS(Back space)キーボタン
    @IBOutlet weak var outletKeyDivideButton: XIPaddingButton!          // ÷キーボタン
    @IBOutlet weak var outletKeyEqualButton: XIPaddingButton!           // =キーボタン

    // MARK: - Private variable
    private var adMgr = AdModMgr()
    private var firstAppear: Bool = false
    
    var seTapButtonAudio : AVAudioPlayer! = nil
    
    // MARK: - ViewController Override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 表示アイテムの初期化
        initEachItem()
        
        // 表示アイテムのローカライズ
        localizeEachItem()
        
        // SE(効果音)の初期化
        initSEAudio()
        
        // 広告マネージャーの初期化
        adMgr.InitManager(pvc:self, cv:outletMainContentsView, lc: outletMainContentsBottomLayoutConstraint)
    }

    /**
     Viewが表示される直前に呼び出されるイベントハンドラー
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 最初に表示される時の処理
        if (firstAppear != true) {
            outletMainContentsView.isHidden = true  // メインコンテンツの準備ができるまで非表示
        }
    }
    
    /**
     Viewが表示された直後に呼び出されるイベントハンドラー
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 最初に表示される時の処理
        if (firstAppear != true) {
            
            procStateMgr(.INIT) // メインコンテンツを初期化
            outletMainContentsView.isHidden = false // メインコンテンツの準備が完了したので表示
        
            adMgr.DispAdView(pos: AdModMgr.DISP_POSITION.BOTTOM)    // 広告の表示
            
            firstAppear = true
        }
    }
    
    /**
     メモリー警告
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     initialize each item
     */
    private func initEachItem() {
        
        // Navibar right button
        outletPreferenceButton.width = 0
        let settingIcon = UIImage(named: "icon_preference")?.ResizeUIImage(width: 20, height: 20)
        outletPreferenceButton.image = settingIcon
    }
    
    /**
     localize each item
     */
    private func localizeEachItem() {
        
        outletNavigationItem.title = NSLocalizedString("STR_MAIN_VIEW_TITLE", comment: "")
        outletHistoryButton.title = NSLocalizedString("STR_MAIN_HISTORY_BUTTON", comment: "")
        outletPreferenceButton.title = ""
        outletExpressionLabel.text = NSLocalizedString("STR_MAIN_EXP_LABEL", comment: "")
        outletAnswerLabel.text = NSLocalizedString("STR_MAIN_ANS_LABEL", comment: "")
        outletDecimalPointTitleLabel.text = NSLocalizedString("STR_MAIN_DECPOS_LABEL", comment: "")
        
    }
    
    /**
     initialize each se audio
     */
    private func initSEAudio() {
        
        // for Tap the button
        let soundFilePath = Bundle.main.path(forResource: "SE_TapButton", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成
        do {
            seTapButtonAudio = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            seTapButtonAudio = nil
            print("AVAudioPlayerインスタンス作成失敗")
        }
        // バッファに保持していつでも再生できるようにする
        seTapButtonAudio.prepareToPlay()
    }
    
    // MARK: - Action method
    /**
     [Action] 小数点位置ダウンボタン 押下
     */
    @IBAction func Action_DecimalPointDownButton_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_DECPOS_DOWN)
    }
    
    /**
     [Action] 小数点位置アップボタン 押下
     */
    @IBAction func Action_DecimalPointUpButton_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_DECPOS_UP)
    }
    
    /**
     [Action] 0ボタン 押下
     */
    @IBAction func Action_Key0Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 0 as AnyObject)
    }
    
    /**
     [Action] 00ボタン 押下
     */
    @IBAction func Action_Key00Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 0 as AnyObject)
        procStateMgr(.TAP_NUM, 0 as AnyObject)
    }
    
    /**
     [Action] 1ボタン 押下
     */
    @IBAction func Action_Key1Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 1 as AnyObject)
    }
    
    /**
     [Action] 2ボタン 押下
     */
    @IBAction func Action_Key2Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 2 as AnyObject)
    }
    
    /**
     [Action] 3ボタン 押下
     */
    @IBAction func Action_Key3Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 3 as AnyObject)
    }
    
    /**
     [Action] 4ボタン 押下
     */
    @IBAction func Action_Key4Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 4 as AnyObject)
    }
    
    /**
     [Action] 5ボタン 押下
     */
    @IBAction func Action_Key5Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 5 as AnyObject)
    }
    
    /**
     [Action] 6ボタン 押下
     */
    @IBAction func Action_Key6Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 6 as AnyObject)
    }
    
    /**
     [Action] 7ボタン 押下
     */
    @IBAction func Action_Key7Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 7 as AnyObject)
    }
    
    /**
     [Action] 8ボタン 押下
     */
    @IBAction func Action_Key8Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 8 as AnyObject)
    }
    
    /**
     [Action] 9ボタン 押下
     */
    @IBAction func Action_Key9Button_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_NUM, 9 as AnyObject)
    }
    
    /**
     [Action] ACボタン 押下
     */
    @IBAction func Action_KeyACButton_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_AC)
    }
    
    /**
     [Action] 小数点ボタン 押下
     */
    @IBAction func Action_DotButton_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_DP)
    }
    
    /**
     [Action] BSボタン 押下
     */
    @IBAction func Action_KeyBSButton_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_BS)
    }
    
    /**
     [Action] ÷ボタン 押下
     */
    @IBAction func Action_KeyDivideButton_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_DIV)
    }
    
    /**
     [Action] =ボタン 押下
     */
    @IBAction func Action_KeyEqualButton_TouchDown(_ sender: Any) {
        procStateMgr(.TAP_EQ)
    }
 
    // MARK: - State Procedure
    // MARK: - State Procedure (変数・定義)
    /**
     ステート定義
    */
    private enum PROC_STATE {
        case WAIT_DIVIDEND  // 割られる値入力待ち 状態 (IDLE)
        case WAIT_DIVISOR   // 割る値入力待ち 状態
        case VIEW_ANSWER    // 答え表示 状態
        case MAXNUM         // イリーガル状態チェック用
    }
    private var procState: PROC_STATE = PROC_STATE.WAIT_DIVIDEND
    
    /**
     イベント定義
     */
    private enum PROC_EVENT {
        case INIT               // 初期化
        case TAP_DECPOS_UP      // 小数点位置Upボタン押下
        case TAP_DECPOS_DOWN    // 小数点位置Downボタン押下
        case TAP_NUM            // 数字ボタン(0,00,1,2,3,4,5,6,7,8,9)押下
        case TAP_DP             // 小数点ボタン
        case TAP_AC             // ACボタン押下
        case TAP_BS             // ←ボタン押下
        case TAP_DIV            // ÷ボタン押下
        case TAP_EQ             // =ボタン押下
        case MAXNUM             // イリーガルイベントチェック用
    }
    
    /**
     あまり割算計算マネージャー
     */
    private let remCalcMgr = RemainderCalculationManager()

    // MARK: - State Procedure (ステートマネージャー処理)
    /**
     Initialization of processing
     - parameter event: Occurred Event
     - parameter param: The parameter of event
     - returns: nothing
     */
    private func procStateMgr( _ event: PROC_EVENT,  _ param: AnyObject? = nil) {
        
        // The common event processing for all state.
        switch event {
        case .INIT:
            // Viewの初期化
            initConfigOfEachView()
            localizeEachItem()
            remCalcMgr.SetDecimalPosition(AppPreference.GetDecimalPoint())
            initStateMgr()
        case .TAP_AC:
            playTapButtonSound()
            initStateMgr()
        default:
            // no action
            break;
            
        }
        
        // Event driven processing
        switch procState {
        case .WAIT_DIVIDEND:
            procstatemgr_Evt_WaitDividend( event, param: param )
        case .WAIT_DIVISOR:
            procstatemgr_Evt_WaitDivisor( event, param: param )
        case .VIEW_ANSWER:
            procstatemgr_Evt_ViewAnswer( event, param: param )
        default:    // Illegal state
            initStateMgr()
            break;
        }
        
        // State driven processing
        changeViewItemColorForState(state: procState)

    }

    /**
     [Event Driven] State: Wait dividend
     - parameter event: Occurred Event
     - parameter param: The parameter of event
     - returns: nothing
     */
    private func procstatemgr_Evt_WaitDividend( _ event: PROC_EVENT, param: AnyObject?) {
        
        switch event {
        case .INIT: // common processing event
            break
        case .TAP_DECPOS_UP:
            evt_TAP_DECPOS_UP()
        case .TAP_DECPOS_DOWN:
            evt_TAP_DECPOS_DOWN()
        case .TAP_NUM:
            evt_TAP_NUM(param as! Int)
            break
        case .TAP_DP:
            evt_TAP_DP()
            break
        case .TAP_AC:   // common processing event
            // common processing event
            break
        case .TAP_BS:
            evt_TAP_BS()
            break
        case .TAP_DIV:
            playTapButtonSound()
            remCalcMgr.DecideDividend()
            updateTextInDisplayArea()
            procState = .WAIT_DIVISOR
            break
        case .TAP_EQ:
            // ignore
            break
        default:    // Illegal event
            evt_ErrorHandling()
            procState = .WAIT_DIVIDEND
            break;
        }
    }
    
    /**
     [Event Driven] State: Wait divisor
     - parameter event: Occurred Event
     - parameter param: The parameter of event
     - returns: nothing
     */
    private func procstatemgr_Evt_WaitDivisor( _ event: PROC_EVENT, param: AnyObject?) {
        
        switch event {
        case .INIT: // common processing event
            break
        case .TAP_DECPOS_UP:
            evt_TAP_DECPOS_UP()
        case .TAP_DECPOS_DOWN:
            evt_TAP_DECPOS_DOWN()
        case .TAP_NUM:
            evt_TAP_NUM(param as! Int)
            break
        case .TAP_DP:
            evt_TAP_DP()
            break
        case .TAP_AC:   // common processing event
            // common processing event
            break
        case .TAP_BS:
            evt_TAP_BS()
            break
        case .TAP_DIV:
            // ignore
            break
        case .TAP_EQ:
            playTapButtonSound()
            remCalcMgr.DecideDiviSor()
            saveDataForHistory()
            procState = .VIEW_ANSWER
            updateTextInDisplayArea()
            break
        default:    // Illegal event
            evt_ErrorHandling()
            procState = .WAIT_DIVIDEND
            break;
        }
    }
    
    /**
     [Event Driven] State: View answer
     - parameter event: Occurred Event
     - parameter param: The parameter of event
     - returns: nothing
     */
    private func procstatemgr_Evt_ViewAnswer( _ event: PROC_EVENT, param: AnyObject?) {
        switch event {
        case .INIT: // common processing event
            break
        case .TAP_DECPOS_UP:
            // ignore
            break
        case .TAP_DECPOS_DOWN:
            // ignore
            break
        case .TAP_NUM:
            // ignore
            break
        case .TAP_DP:
            // ignore
            break
        case .TAP_AC:   // common processing event
            // common processing event
            break
        case .TAP_BS:
            // ignore
            break
        case .TAP_DIV:
            // ignore
            break
        case .TAP_EQ:
            // ignore
            break
        default:    // Illegal event
            evt_ErrorHandling()
            procState = .WAIT_DIVIDEND
            break;
        }
    }
    
    // MARK: - State Procedure (イベント共通処理)
    /**
     TAP_DECPOS_UP
     */
    func evt_TAP_DECPOS_UP() {
        playTapButtonSound()
        remCalcMgr.UpDecimalPosition()
        AppPreference.SetDecimalPoint(value: remCalcMgr.P_DecimalPosition)
        updateTextInDisplayArea()
    }
    
    /**
     TAP_DECPOS_DOWN
     */
    func evt_TAP_DECPOS_DOWN() {
        playTapButtonSound()
        remCalcMgr.DownDecimalPosition()
        AppPreference.SetDecimalPoint(value: remCalcMgr.P_DecimalPosition)
        updateTextInDisplayArea()
    }
    
    /**
     TAP_NUM
     */
    func evt_TAP_NUM(_ number: Int) {
        playTapButtonSound()
        remCalcMgr.InputNumber(number)
        updateTextInDisplayArea()
    }
    
    /**
     TAP_BS
     */
    func evt_TAP_BS() {
        playTapButtonSound()
        remCalcMgr.ExecuteBackSpace()
        updateTextInDisplayArea()
    }
    
    /**
     TAP_DP
     */
    func evt_TAP_DP() {
        playTapButtonSound()
        remCalcMgr.InputDecimalPoint()
        updateTextInDisplayArea()
    }
    
    /**
     Error Handling
     */
    func evt_ErrorHandling() {
        initStateMgr()
        updateTextInDisplayArea()
    }
    
    // MARK: - State Procedure (サブルーチン処理)
    /**
     Initialization state procedures
     */
    private func initStateMgr() {
        remCalcMgr.InitValuesForCalc()
        procState = .WAIT_DIVIDEND
        updateTextInDisplayArea()
    }

    /**
     Update text in display area
     */
    private func updateTextInDisplayArea() {
        
        outletDecimalPointValueLabel.text = remCalcMgr.P_DecPosString           // 小数点位置
        outletInputValueLabel.text = remCalcMgr.P_InputValuesString             // 入力値
        outletExpressionValueLabel.text = remCalcMgr.P_ExpressionString         // 式
        outletExpressionValueLabel.FontSizeToFit()
        outletAnswerValueLabel.text = remCalcMgr.P_AnswerString                 // 答え
        outletAnswerValueLabel.FontSizeToFit()
    }
    
    /**
     Initialize the configuration of each view
     */
    private func initConfigOfEachView() {
        
        // 表示エリア
        outletInputValueLabel.text = "888888888888" // 12桁
        outletInputValueLabel.FontSizeToFit()
        outletInputValueLabel.text = ""
        outletExpressionLabel.FontSizeToFit()
        outletAnswerLabel.FontSizeToFit()
        outletDecimalPointTitleLabel.FontSizeToFit()
        outletDecimalPointDownButton.FontSizeToFit()
        outletDecimalPointValueLabel.FontSizeToFit()
        outletDecimalPointUpButton.FontSizeToFit()
        
        // 入力エリア
        outletKey0Button.FontSizeToFit()
        outletKey00Button.FontSizeToFit()
        outletKey1Button.FontSizeToFit()
        outletKey2Button.FontSizeToFit()
        outletKey3Button.FontSizeToFit()
        outletKey4Button.FontSizeToFit()
        outletKey5Button.FontSizeToFit()
        outletKey6Button.FontSizeToFit()
        outletKey7Button.FontSizeToFit()
        outletKey8Button.FontSizeToFit()
        outletKey9Button.FontSizeToFit()
        outletKeyACButton.FontSizeToFit()
        outletKeyBSButton.FontSizeToFit()
        outletKeyDotButton.FontSizeToFit()
        outletKeyDivideButton.FontSizeToFit()
        outletKeyEqualButton.FontSizeToFit()
    }
    
    /**
     Change the color of each view item color for each state.
     */
    private func changeViewItemColorForState(state: PROC_STATE) {
        
        switch state {
        case .WAIT_DIVIDEND:
            outletInputValueLabel.backgroundColor = UIColor.white
            outletExpressionValueLabel.backgroundColor = UIColor.lightGray
            outletAnswerValueLabel.backgroundColor = UIColor.lightGray
            
            outletDecimalPointDownButton.tintColor = UIColor.white
            outletDecimalPointUpButton.tintColor = UIColor.white
            
            outletKey0Button.tintColor = UIColor.white
            outletKey00Button.tintColor = UIColor.white
            outletKey1Button.tintColor = UIColor.white
            outletKey2Button.tintColor = UIColor.white
            outletKey3Button.tintColor = UIColor.white
            outletKey4Button.tintColor = UIColor.white
            outletKey5Button.tintColor = UIColor.white
            outletKey6Button.tintColor = UIColor.white
            outletKey7Button.tintColor = UIColor.white
            outletKey8Button.tintColor = UIColor.white
            outletKey9Button.tintColor = UIColor.white
            outletKeyDotButton.tintColor = UIColor.white
            
            outletKeyACButton.tintColor = UIColor.white
            outletKeyBSButton.tintColor = UIColor.white
            outletKeyDivideButton.tintColor = UIColor.white
            outletKeyEqualButton.tintColor = UIColor.lightGray
            
        case .WAIT_DIVISOR:
            outletInputValueLabel.backgroundColor = UIColor.white
            outletExpressionValueLabel.backgroundColor = UIColor.hexStr(hexStr: "A5D1F4", alpha: 1.0)
            outletAnswerValueLabel.backgroundColor = UIColor.lightGray
            
            outletDecimalPointDownButton.tintColor = UIColor.white
            outletDecimalPointUpButton.tintColor = UIColor.white
            
            outletKey0Button.tintColor = UIColor.white
            outletKey00Button.tintColor = UIColor.white
            outletKey1Button.tintColor = UIColor.white
            outletKey2Button.tintColor = UIColor.white
            outletKey3Button.tintColor = UIColor.white
            outletKey4Button.tintColor = UIColor.white
            outletKey5Button.tintColor = UIColor.white
            outletKey6Button.tintColor = UIColor.white
            outletKey7Button.tintColor = UIColor.white
            outletKey8Button.tintColor = UIColor.white
            outletKey9Button.tintColor = UIColor.white
            outletKeyDotButton.tintColor = UIColor.white
            
            outletKeyACButton.tintColor = UIColor.white
            outletKeyBSButton.tintColor = UIColor.white
            outletKeyDivideButton.tintColor = UIColor.lightGray
            outletKeyEqualButton.tintColor = UIColor.white
        
        case .VIEW_ANSWER:
            outletInputValueLabel.backgroundColor = UIColor.lightGray
            outletExpressionValueLabel.backgroundColor = UIColor.hexStr(hexStr: "A5D1F4", alpha: 1.0)
            outletAnswerValueLabel.backgroundColor = UIColor.hexStr(hexStr: "EAC7CD", alpha: 1.0)
            
            outletDecimalPointDownButton.tintColor = UIColor.lightGray
            outletDecimalPointUpButton.tintColor = UIColor.lightGray
            
            outletKey0Button.tintColor = UIColor.lightGray
            outletKey00Button.tintColor = UIColor.lightGray
            outletKey1Button.tintColor = UIColor.lightGray
            outletKey2Button.tintColor = UIColor.lightGray
            outletKey3Button.tintColor = UIColor.lightGray
            outletKey4Button.tintColor = UIColor.lightGray
            outletKey5Button.tintColor = UIColor.lightGray
            outletKey6Button.tintColor = UIColor.lightGray
            outletKey7Button.tintColor = UIColor.lightGray
            outletKey8Button.tintColor = UIColor.lightGray
            outletKey9Button.tintColor = UIColor.lightGray
            outletKeyDotButton.tintColor = UIColor.lightGray
            
            outletKeyACButton.tintColor = UIColor.white
            outletKeyBSButton.tintColor = UIColor.lightGray
            outletKeyDivideButton.tintColor = UIColor.lightGray
            outletKeyEqualButton.tintColor = UIColor.lightGray
            
        default:
            break
        }
    }
    
    /**
     履歴用データの保存
     */
    private func saveDataForHistory() {
        
        ModelMgr.Save_D_History(setModel: { (data: D_History) -> Void in
            
            data.m_i_answer = remCalcMgr.P_AnswerString
            data.m_i_expression = remCalcMgr.P_ExpressionString
            
            data.m_i_decimal_position = Int16(remCalcMgr.P_DecimalPosition)
            data.m_i_divisor = remCalcMgr.P_DivisorValue
            data.m_i_dividend = remCalcMgr.P_DividendValue
            
            data.m_k_update_time = Date()
        })
        
        ModelMgr.DeleteDataWithOffset(offset: 50)
    }
    
    /**
     Play tap the button.
     */
    private func playTapButtonSound() {
        
        if ( AppPreference.GetButtonPushedSound() == true ) {
            if ( self.seTapButtonAudio != nil ) {
                self.seTapButtonAudio.play()
            }
        }
    }
}
