//
//  MainViewController.swift
//  ModCalc
//
//  Created by Hiroaki Fujisawa on 2017/04/05.
//  Copyright © 2017年 xinext. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var outletMainContentsView: UIView!
    @IBOutlet weak var outletMainContentsBottomLayoutConstraint: NSLayoutConstraint!
    
    // MARK: - Private
    private var adMgr = AdModMgr()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // AdMod manager
        adMgr.initManager(pvc:self, cv:outletMainContentsView, lc: outletMainContentsBottomLayoutConstraint)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        adMgr.dispAdView(pos: AdModMgr.DISP_POSITION.BOTTOM)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
