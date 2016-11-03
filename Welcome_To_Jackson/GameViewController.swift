//
//  GameViewController.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/22/16.
//  Copyright (c) 2016 Michael Hardin. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

var bgSong = 0

var levelsCompleted = 0
var currentLevel = 1

var interstitial: GADInterstitial!

class GameViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAndLoadInterstitial()
        
        
        bgSong = NSUserDefaults().integerForKey("bgSong")
        
        isMusicPlaying = NSUserDefaults().boolForKey("isMusicPlaying")
        levelsCompleted = NSUserDefaults().integerForKey("LevelsCompleted")
        currentLevel = NSUserDefaults().integerForKey("CurrentLevel")
        
        if isMusicPlaying {
            AudioManager.instance.playBGMusic()
        }
        
        if let scene = MainMenuScene(fileNamed:"MainMenuScene") {
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            skView.showsPhysics = true
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
        }
    }

    func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-6381417154543225/8624542790")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        //request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        interstitial.loadRequest(request)
    }
    
    func runInterstitial(){
        if interstitial.isReady {
            interstitial.presentFromRootViewController(self)
        } else {
            print("Ad wasn't ready")
        }
    }

    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
