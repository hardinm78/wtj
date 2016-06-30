//
//  GameViewController.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/22/16.
//  Copyright (c) 2016 Michael Hardin. All rights reserved.
//

import UIKit
import SpriteKit

var highScore = 0
var levelsCompleted = 0
var currentLevel = 1


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScore = NSUserDefaults().integerForKey("Highscore")
        levelsCompleted = NSUserDefaults().integerForKey("LevelsCompleted")
        currentLevel = NSUserDefaults().integerForKey("CurrentLevel")
        
        if let scene = MainMenuScene(fileNamed:"MainMenuScene") {
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            //skView.showsPhysics = true
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
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
