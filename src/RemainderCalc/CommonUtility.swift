//
//  CommonUtility.swift
//

import Foundation
import UIKit

/**
 - Image Utilty
 - Author: xinext HF
 - Copyright: xinext
 - Date: 2017/04/13
 - Version: 1.0.1
 */
class XIImage {
    
    /**
     Save image data to userdefault.
     - parameter key: image name
     - parameter image: UIImage
     */
    static func SaveUserDefalt( key: String, image: UIImage) {
        
        let imageData = UIImagePNGRepresentation(image)     // convert to Data from UIImage
        UserDefaults.standard.set(imageData, forKey: key)
    }
    
    /**
     Load image data from userdefault.
     - parameter key: image name
     */
    static func LoadUserDefalt( key: String ) -> UIImage? {
        
        let imageData = UserDefaults.standard.data(forKey: key)
        
        return UIImage(data: imageData!)
    }
    
    /**
     Clear image data from userdefalt.
     */
    static func ClearUserDefalt( key: String ) {
        
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func SaveLibrary( name: String, image: UIImage) -> Bool {

        let libPath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last!
        let savePath = libPath.appendingPathComponent(name)
        let pngImageData = UIImagePNGRepresentation(image)
        do {
            try pngImageData!.write(to: savePath)
        } catch {
            return false
        }
        
        return true
    }
    
    static func LoadLibrary( name: String ) -> UIImage? {
        
        let libPath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last!
        let image = UIImage(contentsOfFile: libPath.path)
        
        return image
    }
}

/**
 - [ENG]MessageBox Utilty
 - [JPN]メセージボックスユーティリティー
 - Author: xinext HF
 - Copyright: xinext
 - Date: 2017/02/09
 - Version: 1.0.1
 */
class XIDialog {
    
    /**
     Displays a alert message dialog.
     - parameter pvc: ViewController Parent ViewController.
     - parameter msg: Display message.
     */
    static func DispAlertMsg( pvc:UIViewController, msg: String ){
        
        let titleText = NSLocalizedString("MSG_ALERT", comment: "ALERT")
        let alertController: UIAlertController = UIAlertController(title: titleText, message: msg, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default){
            (action) -> Void in
        }
        alertController.addAction(actionOK)
        pvc.present(alertController, animated: true, completion: nil)
    }
    
    /**
     Displays a selection dialog for navigating to the application setting page.
     - parameter pvc: ViewController Parent ViewController.
     - parameter msg: Display message.
     */
    static func DispSelectSettingPage( pvc:UIViewController, msg: String, cancelHandler: (() -> Swift.Void)? = nil ){
        
        let titleText = NSLocalizedString("MSG_ALERT", comment: "ALERT")
        let alertController: UIAlertController = UIAlertController(title: titleText, message: msg, preferredStyle: .alert)
        
        // Create action and added.
        // Cancel
        let cancelAction:UIAlertAction = UIAlertAction(title: NSLocalizedString("MSG_CANCEL", comment: "Cancel"),
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{(action:UIAlertAction!) in cancelHandler!()
                                                        })
        
        // To Setting page
        let defaultAction:UIAlertAction = UIAlertAction(title: NSLocalizedString("MSG_TO_SETTING_PAGE", comment: "To settings"),
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            let url = NSURL(string:UIApplicationOpenSettingsURLString)
                                                            if #available(iOS 10.0, *) {
                                                                UIApplication.shared.open(url! as URL,options: [:], completionHandler: nil )
                                                            } else {
                                                                UIApplication.shared.openURL(url! as URL)
                                                            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        
        pvc.present(alertController, animated: true, completion: nil)
    }
 }

/**
 - UIColorへ１６進数にてRGB指定できる機能を拡張
 */
extension UIColor {
    class func hexStr ( hexStr : NSString, alpha : CGFloat) -> UIColor {
        let alpha = alpha
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.white;
        }
    }
}

/**
 - UIImageへ画像サイズ調整機能を拡張
 */
extension UIImage{
    func ResizeUIImage(width : CGFloat, height : CGFloat)-> UIImage!{
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

/**
 - 最前面のUIViewController取得機能を拡張
 */
extension UIApplication {
    
    class func GetTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return GetTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return GetTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return GetTopViewController(controller: presented)
        }
        return controller
    }
}

/**
 - UIViewの枠設定機能を拡張
 */
extension UIView {
    
    // 枠線の色
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // 枠線のWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // 角丸設定
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}



