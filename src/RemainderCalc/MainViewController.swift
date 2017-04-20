//
//  MainViewController.swift
//  RemainderCalc
//


import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var outletMainContentsView: UIView!
    @IBOutlet weak var outletMainContentsBottomLayoutConstraint: NSLayoutConstraint!
    
    //タイトルエリア
    @IBOutlet weak var outletNavigationItem: UINavigationItem!  // アプリタイトル
    @IBOutlet weak var outletHistoryButton: UIBarButtonItem!    // 履歴ボタン
    
    // 表示エリア
    @IBOutlet weak var outletInputValuesTextField: UITextField!         // 入力値テキスト
    @IBOutlet weak var outletExpressionLabel: XIPaddingLabel!           // 式タイトルラベル
    @IBOutlet weak var outletExpressionValueTextField: UITextField!     // 式テキスト
    @IBOutlet weak var outletAnswerLabel: XIPaddingLabel!               // 答えタイトル
    @IBOutlet weak var outletAnswerValueTextField: UITextField!         // 答えテキスト
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
    
    // MARK: - ViewController Override
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // AdMod manager
        adMgr.InitManager(pvc:self, cv:outletMainContentsView, lc: outletMainContentsBottomLayoutConstraint)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.initEachView()
        self.localizeEachItem()
        
        adMgr.DispAdView(pos: AdModMgr.DISP_POSITION.BOTTOM)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Internal method

    // MARK: - private method
    /**
     Initialize each view
     */
    private func initEachView() {
        
        //
        outletExpressionLabel.FontSizeToFit()
        outletAnswerLabel.FontSizeToFit()
        outletDecimalPointTitleLabel.FontSizeToFit()
        outletDecimalPointDownButton.FontSizeToFit()
        outletDecimalPointValueLabel.FontSizeToFit()
        outletDecimalPointUpButton.FontSizeToFit()
        outletKey0Button.FontSizeToFit()
        outletKey00Button.FontSizeToFit()
        
        outletKey7Button.FontSizeToFit()
        outletKey8Button.FontSizeToFit()
        outletKey9Button.FontSizeToFit()
        outletKeyACButton.FontSizeToFit()
        outletKey4Button.FontSizeToFit()
        outletKey5Button.FontSizeToFit()
        outletKey6Button.FontSizeToFit()
        outletKeyBSButton.FontSizeToFit()
        outletKey1Button.FontSizeToFit()
        outletKey2Button.FontSizeToFit()
        outletKey3Button.FontSizeToFit()
        outletKeyDotButton.FontSizeToFit()
        outletKeyDivideButton.FontSizeToFit()
        outletKeyEqualButton.FontSizeToFit()
        
        outletInputValuesTextField.isUserInteractionEnabled = false
        outletExpressionValueTextField.isUserInteractionEnabled = false
        outletAnswerValueTextField.isUserInteractionEnabled = false
        
    }
    
    /**
     localize each item
     */
    private func localizeEachItem() {
     
       outletNavigationItem.title = NSLocalizedString("STR_MAIN_VIEW_TITLE", comment: "")
       outletHistoryButton.title = NSLocalizedString("STR_MAIN_HISTORY_BUTTON", comment: "")
       outletExpressionLabel.text = NSLocalizedString("STR_MAIN_EXP_LABEL", comment: "")
       outletAnswerLabel.text = NSLocalizedString("STR_MAIN_ANS_LABEL", comment: "")
       outletDecimalPointTitleLabel.text = NSLocalizedString("STR_MAIN_DECPOS_LABEL", comment: "")
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
