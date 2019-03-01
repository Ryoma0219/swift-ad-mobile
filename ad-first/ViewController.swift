//
//  ViewController.swift
//  ad-first
//
//  Created by Ryoma HOSHINO on 2019/02/28.
//  Copyright © 2019 Ryoma HOSHINO. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADInterstitialDelegate, GADRewardBasedVideoAdDelegate  {
    
    @IBOutlet var buttonTest :UIButton!
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!

    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // interstitial setting
        interstitial = createAndLoadInterstitial()

        // bannar setting
        bannerView = GADBannerView(adSize: kGADAdSizeLargeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        addBannerViewToView(bannerView)
        bannerView.load(GADRequest())

        // video setting
        GADRewardBasedVideoAd.sharedInstance().delegate = self

        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
            withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
    }
    
    // interstitial button tapped
    @IBAction func buttonTapped(_ sender : Any) {
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        }
    }
    
    // video button tapped
    @IBAction func videoTapped(_ sender : Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        //
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        
    }
    
    /* bannar setting */
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    /* end bannar setting*/
 
    
    /* inserttitial setting */
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    /* end inserttitial setting */
    
    // video setting
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
            withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
    }

}

