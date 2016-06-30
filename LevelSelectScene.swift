//
//  LevelSelectScene.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/27/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit


class LevelSelectScene: SKScene {
    
    var highlight = SKSpriteNode()
    var countyLine = SKSpriteNode()
    var capitol = SKSpriteNode()
    var ridgewood = SKSpriteNode()
    var high = SKSpriteNode()
    var state = SKSpriteNode()
    var terry = SKSpriteNode()
    var fortification = SKSpriteNode()
    var mcDowell = SKSpriteNode()
    var ellis = SKSpriteNode()
    var woodrowWilson = SKSpriteNode()
    var oldCanton = SKSpriteNode()
    var lakeland = SKSpriteNode()
    
    
    
    
    override func didMoveToView(view: SKView) {
        initialize()
        initialHighlightPosition()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "Back"{
                
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenu!.scaleMode = .AspectFit
                self.view?.presentScene(mainMenu!, transition:SKTransition.fadeWithColor(UIColor.orangeColor(), duration: NSTimeInterval(1.5)))
            }
            //            if nodeAtPoint(location).name == "CountyLine" {
            //                highlight.position = nodeAtPoint(location).position
            //            }
            switch nodeAtPoint(location).name! {
                
            case "CountyLine":
                highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                currentLevel = 0
                NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "CurrentLevel")
                
            case "Capitol":
                if nodeAtPoint(location).alpha == 1 {
                    currentLevel = 1
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "CurrentLevel")
                    
                }
                
            case "Ridgewood":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "CurrentLevel")
                    
                }
            case "High":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "CurrentLevel")
                    
                }
            case "State":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(4, forKey: "CurrentLevel")
                   
                }
            case "Terry":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(5, forKey: "CurrentLevel")
                    
                }
            case "Fortification":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(6, forKey: "CurrentLevel")
                    
                }
            case "McDowell":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(7, forKey: "CurrentLevel")
                    
                }
            case "Ellis":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(8, forKey: "CurrentLevel")
                    
                }
            case "WoodrowWilson":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                    
                    NSUserDefaults.standardUserDefaults().setInteger(9, forKey: "CurrentLevel")
                    
                }
            case "OldCanton":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                   
                    NSUserDefaults.standardUserDefaults().setInteger(10, forKey: "CurrentLevel")
                   
                }
            case "Lakeland":
                if nodeAtPoint(location).alpha == 1 {
                    highlight.position = CGPoint(x: nodeAtPoint(location).position.x + 2 , y: nodeAtPoint(location).position.y - 2)
                   
                    NSUserDefaults.standardUserDefaults().setInteger(11, forKey: "CurrentLevel")
                   
                }
            default:
                break
                
                
            }
            
            
        }
    }
    func initialize(){
        highlight = childNodeWithName("Highlight") as! SKSpriteNode
        createBtns()
        createBG()
        createGrounds()
            }
    
    
   
    
    override func update(currentTime: NSTimeInterval) {
        moveBackgroundsAndGrounds()
    }
    
    func createBtns() {
        countyLine = childNodeWithName("CountyLine") as! SKSpriteNode
        
        
        capitol = childNodeWithName("Capitol") as! SKSpriteNode
        capitol.alpha = 0.5
        if levelsCompleted >= 1 {
            capitol.alpha = 1
        }
        
        ridgewood = childNodeWithName("Ridgewood") as! SKSpriteNode
        ridgewood.alpha = 0.5
        if levelsCompleted >= 2 {
            ridgewood.alpha = 1
        }
        
        high = childNodeWithName("High") as! SKSpriteNode
        high.alpha = 0.5
        if levelsCompleted >= 3 {
            high.alpha = 1
        }
        
        state = childNodeWithName("State") as! SKSpriteNode
        state.alpha = 0.5
        if levelsCompleted >= 4 {
            state.alpha = 1
        }
        
        terry = childNodeWithName("Terry") as! SKSpriteNode
        terry.alpha = 0.5
        if levelsCompleted >= 5 {
            terry.alpha = 1
        }
        
        fortification = childNodeWithName("Fortification") as! SKSpriteNode
        fortification.alpha = 0.5
        if levelsCompleted >= 6 {
            fortification.alpha = 1
        }
        
        mcDowell = childNodeWithName("McDowell") as! SKSpriteNode
        mcDowell.alpha = 0.5
        if levelsCompleted >= 7 {
            mcDowell.alpha = 1
        }
        
        ellis = childNodeWithName("Ellis") as! SKSpriteNode
        ellis.alpha = 0.5
        if levelsCompleted >= 8 {
            ellis.alpha = 1
        }
        
        woodrowWilson = childNodeWithName("WoodrowWilson") as! SKSpriteNode
        woodrowWilson.alpha = 0.5
        if levelsCompleted >= 9 {
            woodrowWilson.alpha = 1
        }
        
        oldCanton = childNodeWithName("OldCanton") as! SKSpriteNode
        oldCanton.alpha = 0.5
        if levelsCompleted >= 10 {
            oldCanton.alpha = 1
        }
        lakeland = childNodeWithName("Lakeland") as! SKSpriteNode
        lakeland.alpha = 0.5
        if levelsCompleted >= 11 {
            lakeland.alpha = 1
        }
        
        
       highlight.position = CGPoint(x: countyLine.position.x + 2 , y: countyLine.position.y - 2)
        
    }
    
    
    
    func initialHighlightPosition(){
        switch currentLevel {
        case 0:
             highlight.position = CGPoint(x: countyLine.position.x + 2 , y: countyLine.position.y - 2)
        case 1:
            highlight.position = CGPoint(x: capitol.position.x + 2 , y: capitol.position.y - 2)
        case 2:
            highlight.position = CGPoint(x: ridgewood.position.x + 2 , y: ridgewood.position.y - 2)
        case 3:
            highlight.position = CGPoint(x: high.position.x + 2 , y: high.position.y - 2)
        case 4:
            highlight.position = CGPoint(x: state.position.x + 2 , y: state.position.y - 2)
        case 5:
            highlight.position = CGPoint(x: terry.position.x + 2 , y: terry.position.y - 2)
        case 6:
            highlight.position = CGPoint(x: fortification.position.x + 2 , y: fortification.position.y - 2)
        case 7:
            highlight.position = CGPoint(x: mcDowell.position.x + 2 , y: mcDowell.position.y - 2)
        case 8:
            highlight.position = CGPoint(x: ellis.position.x + 2 , y: ellis.position.y - 2)
        case 9:
            highlight.position = CGPoint(x: woodrowWilson.position.x + 2 , y: woodrowWilson.position.y - 2)
        case 10:
            highlight.position = CGPoint(x: oldCanton.position.x + 2 , y: oldCanton.position.y - 2)
        case 11:
            highlight.position = CGPoint(x: lakeland.position.x + 2 , y: lakeland.position.y - 2)
        default:
            break
            
            
            
            
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
            let g = SKSpriteNode(imageNamed: "Ground2")
            g.name = "Ground"
            g.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            g.position = CGPoint(x: CGFloat(i) * g.size.width, y: -(self.frame.size.height/2))
            g.zPosition = 2
            
            self.addChild(g)
        }
    }
    func moveBackgroundsAndGrounds() {
        
        enumerateChildNodesWithName("BG",usingBlock: ({ (node, error) in
            node.position.x -= 4
            
            let bgNode = node as! SKSpriteNode
            
            if bgNode.position.x < -(self.frame.width){
                bgNode.position.x += bgNode.size.width * 3
            }
            
            
            
        }))
        
        enumerateChildNodesWithName("Ground",usingBlock: ({ (node, error) in
            node.position.x -= 2
            
            let gNode = node as! SKSpriteNode
            
            if gNode.position.x < -(self.frame.width){
                gNode.position.x += gNode.size.width * 3
            }
        }))
    }
    
}