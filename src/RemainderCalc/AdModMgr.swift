//
//  AdModMgr.swift
//

import UIKit
import GoogleMobileAds

/**
 AdMod管理用 UIViewController
 - Author: xinext HF
 - Copyright: xinext
 - Date: 2017/09/24
 - Version: 1.0.3
 - Remark: ADMOD_UNITID 及び、ADMOD_TESTID を別途定義する必要があります。
           それぞれのIDはGoogle AdModの仕様に従って取得してください。
           また、リリース時は、ADMOD_TESTIDをセットしない様にTestModeをfalseへ設定してください。
 */
class AdModMgr: UIViewController, GADBannerViewDelegate {
    
    // MARK: - Internal variable
    let adBannerView = GADBannerView(adSize:kGADAdSizeSmartBannerPortrait)
    
    // MARK: - Privet variable
    private var _contentsView: UIView!
    private var _layoutConstraint: NSLayoutConstraint? = nil
    
    enum DISP_POSITION: Int {
        case TOP = 0
        case BOTTOM
    }
    
    // MARK: - Public method
    /**
     ADマネージャーの初期化
     - parameter pvc: ADをつけるUIViewの親UIViewController
     - parameter cv: ADをつけるUIView(コンテナビュー)
     - parameter lc: 表示位置により上下どちらかのLayoutConstraintを渡す。
     */
    func InitManager(pvc: UIViewController, cv: UIView, lc: NSLayoutConstraint) {
        
        GADMobileAds.configure(withApplicationID: ADMOD_APPID)
        
        pvc.addChildViewController(self)
        
        _contentsView = cv
        _layoutConstraint = lc
        
        adBannerView.isHidden = true
        adBannerView.adUnitID = ADMOD_UNITID
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        let gadRequest:GADRequest = GADRequest()
        
#if false // Test mode
    gadRequest.testDevices = [ADMOD_TESTID]
    notifyDebugMode(pvc: pvc)
#endif
        
        adBannerView.load(gadRequest)
        self.parent?.view.addSubview(adBannerView)
    }
    
    /**
     Display AdView.
     - parameter pos: DISP_POSITION
     - returns: nothing
     */
    func DispAdView(pos: DISP_POSITION) {
        
        var rectBanner: CGRect
        
        let banner_x: CGFloat = 0.0
        let banner_width: CGFloat = adBannerView.frame.size.width
        let banner_height: CGFloat = adBannerView.frame.size.height
        let banner_y: CGFloat
        switch pos {
        case DISP_POSITION.TOP:
            // バナーの縦位置 = メインコンテンツの縦位置
            banner_y = _contentsView!.frame.origin.y
        default:    // bottom
            // バナーの縦位置 = (メインコンテンツの高さ - バナーの高さ) + メインコンテンツの縦位置
            banner_y = (_contentsView.frame.height - adBannerView.frame.size.height) + _contentsView.frame.origin.y
        }
        rectBanner = CGRect(x: banner_x, y: banner_y, width: banner_width, height: banner_height)
        adBannerView.frame = rectBanner
        
        if ( adBannerView.isHidden == true ) {
            _layoutConstraint?.constant += adBannerView.frame.size.height
        }
        else {
            // do nothign.
        }
        
        adBannerView.isHidden = false
    }
    
    /**
     Hide AdView.
     - parameter pos: DISP_POSITION
     - returns: nothing
     */
    func HideAdView() {
        
        if ( adBannerView.isHidden == false ) {
            _layoutConstraint?.constant -= adBannerView.frame.size.height
        }
        else {
            // do nothign.
        }
        
        adBannerView.isHidden = true
    }
    
    // MARK: - private method
    private func notifyDebugMode( pvc: UIViewController ) {
        
        let alertController: UIAlertController = UIAlertController(title: "＊＊＊注意＊＊＊", message: "AdMod is debug mode.", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default){
            (action) -> Void in
        }
        alertController.addAction(actionOK)
        pvc.present(alertController, animated: true, completion: nil)

    }
}
