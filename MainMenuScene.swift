//
//  MainMenuScene.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/24/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit



class MainMenuScene:SKScene {
    
    var playBtn = SKSpriteNode()
    var scoreBtn = SKSpriteNode()
    var title = SKSpriteNode()
    
    var scoreLabel = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        highScore = NSUserDefaults().integerForKey("Highscore")
        initialize()
        
    }
    
    func initialize(){
        createBG()
        createGrounds()
        getLogo()
        getButtons()
        showScore()
    }
    
    override func update(currentTime: NSTimeInterval) {
        moveBackgroundsAndGrounds()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location) == playBtn {
                let level = Level1(fileNamed: "Level1")
                level?.scaleMode = .AspectFit
                self.view?.presentScene(level!, transition: SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
                
            }
            
            if nodeAtPoint(location) == scoreBtn {
                showScore() 
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
            let g = SKSpriteNode(imageNamed: "Ground2")
            g.name = "Ground"
            g.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            g.position = CGPoint(x: CGFloat(i) * g.size.width, y: -(self.frame.size.height/2))
            g.zPosition = 3
            
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

    func getButtons() {
        playBtn = self.childNodeWithName("Play") as! SKSpriteNode
        scoreBtn = self.childNodeWithName("Score") as! SKSpriteNode
        
        
    }

    func getLogo() {
        title = childNodeWithName("Title") as! SKSpriteNode
        
        
        let moveUp = SKAction.moveToY(title.position.y + 10, duration: NSTimeInterval(1))
        let moveDown = SKAction.moveToY(title.position.y - 10, duration: NSTimeInterval(1))
        
        let sequence = SKAction.sequence([moveUp,moveDown])
        
        title.runAction(SKAction.repeatActionForever(sequence))
        
    }
    
    
    
    func showScore() {
        scoreLabel.removeFromParent()
        scoreLabel = SKLabelNode(fontNamed: "Highway Gothic")
        scoreLabel.fontSize = 120
        scoreLabel.text = "\(highScore)"
        scoreLabel.position = CGPoint(x: 0, y: -200)
        scoreLabel.zPosition = 9
        
        self.addChild(scoreLabel)
        
        
    }
    
    
    
    
}