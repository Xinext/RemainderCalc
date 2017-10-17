//
//  PreferenceTableViewController.swift
//  RemainderCalc
//

import UIKit

class PreferenceTableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    // Sound section
    @IBOutlet weak var outletTapButtonSoundLabel: UILabel!
    @IBOutlet weak var outletTapButtonSoundSwich: UISwitch!
    
    // MARK: - Private vriable
    // Each section title text
    var sectionTitleArray: Array<String> = Array()
    
    // MARK: - ViewController Override
    /**
     View生成時に呼び出されるイベントハンドラー
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 各アイテムの初期化
        localizeEachItem()  // ローカライズ
    }

    /**
     Viewが表示される直前に呼び出されるイベントハンドラー
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reflected the latest setting to ViewItem
        outletTapButtonSoundSwich.isOn = AppPreference.GetButtonPushedSound()
    }
    
    /**
     メモリー警告
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     localize each item
     */
    private func localizeEachItem() {
        
        outletTapButtonSoundLabel.text = NSLocalizedString("STR_PREF_TAP_BUTTON_LABEL", comment: "Tap the button.")
        
        sectionTitleArray.removeAll()
        sectionTitleArray += [NSLocalizedString("STR_PREF_SUBTITLE_SOUND", comment: "Sound")]
    }
    
    // MARK: - IBAction
    /**
     [action]ボタンタップ音スイッチの切り替え
     */
    @IBAction func actionTapButtonSoundSwich_ValueChange(_ sender: Any) {
        AppPreference.SetButtonPushedSound(value: outletTapButtonSoundSwich.isOn)
    }
    
    // MARK: - Table view data source
    // Sectioのタイトル設定
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArray[section]
    }
    
}
