//
//  Background.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/30/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit


class BGAndGround {
    
    var bgImage = "BG"
    
    
    func createBG(scene:SKScene) {
        
        switch currentLevel {
        case 0:
            bgImage = "BG3"
        case 1:
            bgImage = "BG4"
        case 2:
            bgImage = "rdwood"
        case 3:
            bgImage = "High"
        case 4:
            bgImage = "State"
            
        default:
            break
        }
        
        
        
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: bgImage)
            bg.name = "BG"
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0)
            bg.zPosition = 0
            scene.addChild(bg)
            
                        
        }
    }
    func createGrounds(scene:SKScene) {
        for i in 0...2 {
            let g = SKSpriteNode(imageNamed: "rd4x")
            g.name = "Ground"
            g.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            g.position = CGPoint(x: CGFloat(i) * g.size.width, y: -(scene.frame.size.height/2) + 50)
            g.zPosition = 3
            g.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: g.size.width, height: g.size.height - 80))
            g.physicsBody?.affectedByGravity = false
            g.physicsBody?.dynamic = false
            g.physicsBody?.categoryBitMask = ColliderType.Ground
           
            scene.addChild(g)
        }
    }
    
    func moveBackgroundsAndGrounds(scene:SKScene) {
        
        scene.enumerateChildNodesWithName("BG",usingBlock: ({ (node, error) in
            node.position.x -= 2
            
            let bgNode = node as! SKSpriteNode
            
            if bgNode.position.x < -(scene.frame.width){
                bgNode.position.x += bgNode.size.width * 3
            }
            
            
            
        }))
        
        scene.enumerateChildNodesWithName("Ground",usingBlock: ({ (node, error) in
            node.position.x -= 10
            
            let gNode = node as! SKSpriteNode
            
            if gNode.position.x < -(scene.frame.width){
                gNode.position.x += gNode.size.width * 3
            }
        }))
    }

    
    
    
    
    
    
    
}