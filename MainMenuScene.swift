//
//  MainMenuScene.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/24/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit

  var isMusicPlaying = true



class MainMenuScene:SKScene {
    
    private var musicBtn = SKSpriteNode()
    private let musicON = SKTexture(imageNamed: "MusicOn")
    private let musicOFF = SKTexture(imageNamed: "MusicOff")
    
    
    var playBtn = SKSpriteNode()
    var optionsBtn = SKSpriteNode()
    var levelSelectBtn = SKSpriteNode()
    var title = SKSpriteNode()
    
    var currentLvlLabel = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
       
        
        
        levelsCompleted = NSUserDefaults().integerForKey("LevelsCompleted")
        currentLevel = NSUserDefaults().integerForKey("CurrentLevel")
        initialize()
        
       print(levelsCompleted)
    }
    
    func initialize(){
        createBG()
        createGrounds()
        getLogo()
        getButtons()
        showLvl()
     
    }
    
    func loadCurrentLevel(currentLevel:Int) {
        
        switch currentLevel {
        case 0:
            let level = CountyLine(fileNamed: "CountyLine")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 1:
            let level = Capitol(fileNamed: "Capitol")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 2:
            let level = Ridgewood(fileNamed: "Ridgewood")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 3:
            let level = High(fileNamed: "High")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 4:
            let level = State(fileNamed: "State")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))            
        case 5:
            let level = Terry(fileNamed: "Terry")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 6:
            let level = Fortification(fileNamed: "Fortification")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 7:
            let level = McDowell(fileNamed: "McDowell")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 8:
            let level = Ellis(fileNamed: "Ellis")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 9:
            let level = WoodrowWilson(fileNamed: "WoodrowWilson")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 10:
            let level = OldCanton(fileNamed: "OldCanton")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        case 11:
            let level = Lakeland(fileNamed: "Lakeland")
            level?.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        default:
            break
            
        }
        
        
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        moveBackgroundsAndGrounds()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            print(currentLevel)
            let location = touch.locationInNode(self)
             if nodeAtPoint(location) == playBtn {
                playBtn.texture = SKTexture(imageNamed: "Playr2")
                loadCurrentLevel(currentLevel)
            }
            
            if nodeAtPoint(location) == optionsBtn {
                let options = OptionsScene(fileNamed: "OptionsScene")
                optionsBtn.texture = SKTexture(imageNamed: "Options 2")
                options?.scaleMode = .AspectFit
                self.view?.presentScene(options!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
            }
            
            
            if nodeAtPoint(location) == levelSelectBtn {
                let lvlSel = LevelSelectScene(fileNamed: "LevelSelectScene")
                levelSelectBtn.texture = SKTexture(imageNamed: "Level Select 2")
                lvlSel?.scaleMode = .AspectFit
                self.view?.presentScene(lvlSel!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
            }
            
            
            if nodeAtPoint(location) == musicBtn {
                if !isMusicPlaying{
                    isMusicPlaying = true
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isMusicPlaying")
                    AudioManager.instance.playBGMusic()
                    musicBtn.texture = musicON
                }else {
                    isMusicPlaying = false
                    NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isMusicPlaying")
                    AudioManager.instance.stopBGMusic()
                    musicBtn.texture = musicOFF
                }
            }
        }
        
    }
    
    
    func createBG() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "BG3")
            bg.name = "BG"
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            bg.zPosition = 0
            self.addChild(bg)
        }
    }
    func createGrounds() {
        for i in 0...2 {
            let g = SKSpriteNode(imageNamed: "rd4x")
            g.name = "Ground"
            g.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            g.position = CGPoint(x: CGFloat(i) * g.size.width, y: -(self.frame.size.height/2) + 50)
            g.zPosition = 3
            
            self.addChild(g)
        }
    }
    func moveBackgroundsAndGrounds() {
        
        enumerateChildNodesWithName("BG",usingBlock: ({ (node, error) in
            node.position.x -= 2
            
            let bgNode = node as! SKSpriteNode
            
            if bgNode.position.x < -(self.frame.width){
                bgNode.position.x += bgNode.size.width * 3
            }
        }))
        
        enumerateChildNodesWithName("Ground",usingBlock: ({ (node, error) in
            node.position.x -= 4
            
            let gNode = node as! SKSpriteNode
            
            if gNode.position.x < -(self.frame.width){
                gNode.position.x += gNode.size.width * 3
            }
        }))
    }

    func getButtons() {
        playBtn = self.childNodeWithName("Play") as! SKSpriteNode
        optionsBtn = self.childNodeWithName("Options") as! SKSpriteNode
        musicBtn = self.childNodeWithName("Music") as! SKSpriteNode
        levelSelectBtn = self.childNodeWithName("Level Select") as! SKSpriteNode
        
        if isMusicPlaying {
            musicBtn.texture = musicON
            
        }else {
            musicBtn.texture = musicOFF
        }
        
    }

    func getLogo() {
        title = childNodeWithName("Title") as! SKSpriteNode
        
        let moveUp = SKAction.moveToY(title.position.y + 10, duration: NSTimeInterval(2))
        let moveDown = SKAction.moveToY(title.position.y - 10, duration: NSTimeInterval(2))
        
        let sequence = SKAction.sequence([moveUp,moveDown])
        
        title.runAction(SKAction.repeatActionForever(sequence))
        
    }
    
    func showLvl() {
       
        currentLvlLabel = childNodeWithName("Current Level") as! SKSpriteNode
    
        
        switch currentLevel {
        case 0:
            currentLvlLabel.texture = SKTexture(imageNamed: "County Line Rd")
        case 1:
            currentLvlLabel.texture = SKTexture(imageNamed: "Capitol")
        case 2:
            currentLvlLabel.texture = SKTexture(imageNamed: "Ridgewood")
        case 3:
            currentLvlLabel.texture = SKTexture(imageNamed: "High St")
        case 4:
            currentLvlLabel.texture = SKTexture(imageNamed: "State St")
        case 5:
            currentLvlLabel.texture = SKTexture(imageNamed: "Terry Rd")
        case 6:
            currentLvlLabel.texture = SKTexture(imageNamed: "Fortification")
        case 7:
            currentLvlLabel.texture = SKTexture(imageNamed: "McDowell Rd")
        case 8:
            currentLvlLabel.texture = SKTexture(imageNamed: "Ellis Ave")
        case 9:
            currentLvlLabel.texture = SKTexture(imageNamed: "Woodrow Wilson")
        case 10:
            currentLvlLabel.texture = SKTexture(imageNamed: "Old Canton")
        case 11:
            currentLvlLabel.texture = SKTexture(imageNamed: "Lakeland")
        default:
            break
            
            
            
            
        }

        
    }
    
    
    
    
}