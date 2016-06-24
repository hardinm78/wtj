//
//  Player.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/22/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit


struct ColliderType {
    
    static let Player: UInt32 = 1
    static let Ground: UInt32 = 2
    static let Obstacle: UInt32 = 3
   }


class Player:SKSpriteNode {
   
    func initialize() {
        
        var run = [SKTexture]()
        
        for i in 0...23 {
            let name = "Running\(i)"
            run.append(SKTexture(imageNamed:name))
        }
        
        let runAnimation = SKAction.animateWithTextures(run, timePerFrame: NSTimeInterval(0.03), resize: true, restore: true)
        
        
        
        
        self.name = "Player"
        self.zPosition = 2
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.setScale(0.4)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width-20, height: self.size.height-20))
        self.physicsBody?.mass = 0.2
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Ground | ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Ground | ColliderType.Obstacle
        
        
        self.runAction(SKAction.repeatActionForever(runAnimation))
        
        
        }
    func jump() {
        self.physicsBody!.velocity = CGVector(dx: 0, dy:0)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 220))
        print("jumped")
    }
    
}