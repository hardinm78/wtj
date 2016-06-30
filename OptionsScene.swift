//
//  OptionsScene.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/27/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit

class OptionsScene:SKScene {
    
    
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
        }
    }
    func initialize(){
        createBG()
        createGrounds()
    }
    
    override func update(currentTime: NSTimeInterval) {
        moveBackgroundsAndGrounds()
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
    
    
}
