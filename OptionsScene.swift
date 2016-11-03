//
//  OptionsScene.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/27/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit

class OptionsScene:SKScene {
    
    var bgON = SKLabelNode()
    var bgOFF = SKLabelNode()
    
    var song0Label = SKLabelNode()
    var song1Label = SKLabelNode()
    var song2Label = SKLabelNode()
    var song3Label = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        initialize()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "Back"{
                
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenu!.scaleMode = .AspectFit
                self.view?.presentScene(mainMenu!, transition:SKTransition.fadeWithColor(UIColor.orangeColor(), duration: NSTimeInterval(1.5)))
                
            }
            
            if nodeAtPoint(location) == bgON {
                bgON.fontColor = UIColor.whiteColor()
                bgOFF.fontColor = UIColor.redColor()
                if !isMusicPlaying{
                    isMusicPlaying = true
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isMusicPlaying")
                    AudioManager.instance.playBGMusic()
                }
            }
            if nodeAtPoint(location) == bgOFF {
                bgON.fontColor = UIColor.redColor()
                bgOFF.fontColor = UIColor.whiteColor()
                isMusicPlaying = false
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isMusicPlaying")
                AudioManager.instance.stopBGMusic()
            }
            
            
            if nodeAtPoint(location) == song0Label{
                
                AudioManager.instance.stopBGMusic()
                song0Label.fontColor = UIColor.whiteColor()
                song1Label.fontColor = UIColor.redColor()
                song2Label.fontColor = UIColor.redColor()
                song3Label.fontColor = UIColor.redColor()
                bgSong = 0
                NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "bgSong")
                AudioManager.instance.playBGMusic()
                
                isMusicPlaying = true
                bgON.fontColor = UIColor.whiteColor()
                bgOFF.fontColor = UIColor.redColor()
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isMusicPlaying")
            }

            if nodeAtPoint(location) == song1Label{
                
                AudioManager.instance.stopBGMusic()
                song0Label.fontColor = UIColor.redColor()
                song1Label.fontColor = UIColor.whiteColor()
                song2Label.fontColor = UIColor.redColor()
                song3Label.fontColor = UIColor.redColor()
                bgSong = 1
                NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "bgSong")
                AudioManager.instance.playBGMusic()
                isMusicPlaying = true
                bgON.fontColor = UIColor.whiteColor()
                bgOFF.fontColor = UIColor.redColor()
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isMusicPlaying")
            }
            if nodeAtPoint(location) == song2Label{
               
                AudioManager.instance.stopBGMusic()
                song0Label.fontColor = UIColor.redColor()
                song1Label.fontColor = UIColor.redColor()
                song2Label.fontColor = UIColor.whiteColor()
                song3Label.fontColor = UIColor.redColor()
                bgSong = 2
                NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "bgSong")
                AudioManager.instance.playBGMusic()
                isMusicPlaying = true
                bgON.fontColor = UIColor.whiteColor()
                bgOFF.fontColor = UIColor.redColor()
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isMusicPlaying")
            }
            if nodeAtPoint(location) == song3Label{
                
                AudioManager.instance.stopBGMusic()
                song0Label.fontColor = UIColor.redColor()
                song1Label.fontColor = UIColor.redColor()
                song2Label.fontColor = UIColor.redColor()
                song3Label.fontColor = UIColor.whiteColor()
                bgSong = 3
                NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "bgSong")
                AudioManager.instance.playBGMusic()
                isMusicPlaying = true
                bgON.fontColor = UIColor.whiteColor()
                bgOFF.fontColor = UIColor.redColor()
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isMusicPlaying")
            }

        }
    }
    func initialize(){
        song0Label = childNodeWithName("0") as! SKLabelNode
        song1Label = childNodeWithName("1") as! SKLabelNode
        song2Label = childNodeWithName("2") as! SKLabelNode
        song3Label = childNodeWithName("3") as! SKLabelNode
        
        bgON = childNodeWithName("ON") as! SKLabelNode
        bgOFF = childNodeWithName("OFF") as! SKLabelNode
        
       if isMusicPlaying {
            bgON.fontColor = UIColor.whiteColor()
            bgOFF.fontColor = UIColor.redColor()
        } else {
            bgON.fontColor = UIColor.redColor()
            bgOFF.fontColor = UIColor.whiteColor()
        }
        
        switch bgSong {
        case 0:
            song0Label.fontColor = UIColor.whiteColor()
            song1Label.fontColor = UIColor.redColor()
            song2Label.fontColor = UIColor.redColor()
            song3Label.fontColor = UIColor.redColor()
        case 1:
            song0Label.fontColor = UIColor.redColor()
            song1Label.fontColor = UIColor.whiteColor()
            song2Label.fontColor = UIColor.redColor()
            song3Label.fontColor = UIColor.redColor()
        case 2:
            song0Label.fontColor = UIColor.redColor()
            song1Label.fontColor = UIColor.redColor()
            song2Label.fontColor = UIColor.whiteColor()
            song3Label.fontColor = UIColor.redColor()
        case 3:
            song0Label.fontColor = UIColor.redColor()
            song1Label.fontColor = UIColor.redColor()
            song2Label.fontColor = UIColor.redColor()
            song3Label.fontColor = UIColor.whiteColor()
        default:
            song0Label.fontColor = UIColor.whiteColor()
            song1Label.fontColor = UIColor.redColor()
            song2Label.fontColor = UIColor.redColor()
            song3Label.fontColor = UIColor.redColor()
        }
        
        
        
    }
    
    override func update(currentTime: NSTimeInterval) {
       
    }
    
    
}
