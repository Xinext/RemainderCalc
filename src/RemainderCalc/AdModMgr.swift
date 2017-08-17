//
//  AdModMgr.swift
//

import UIKit
import GoogleMobileAds

/**
 AdMod管理用 UIViewController
 - Author: xinext HF
 - Copyright: xinext
 - Date: 2017/04/18
 - Version: 1.0.2
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
     Initialization of processing
     - parameter pvc: ViewController Parent ViewController.
     - parameter cv: UIView The view of contents related to AD.
     - parameter cv: UIView The layout constraint of contents view.
     - returns: nothing
     */
    func InitManager(pvc: UIViewController, cv: UIView, lc: NSLayoutConstraint) {
        
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
            banner_y = _contentsView!.frame.origin.y
        default:    // bottom
            banner_y = self.view.frame.size.height - adBannerView.frame.size.height
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
