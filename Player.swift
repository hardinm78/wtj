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
        self.zPosition = 4
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.setScale(0.5)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width-50, height: self.size.height-20))
        self.physicsBody?.mass = 1
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Ground | ColliderType.Obstacle
        self.physicsBody?.contactTestBitMask = ColliderType.Ground | ColliderType.Obstacle
        
        
        self.runAction(SKAction.repeatActionForever(runAnimation))
        
        
        }
    func jump() {
        self.physicsBody!.velocity = CGVector(dx: 0, dy:0)
        self.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 1040))
        
        var jumping = [SKTexture]()
        
        for i in 0...39 {
            let name = "Jumping\(i)"
            jumping.append(SKTexture(imageNamed:name))
        }
        
        let jumpAnimation = SKAction.animateWithTextures(jumping, timePerFrame: NSTimeInterval(0.03), resize: true, restore: true)
        self.runAction(jumpAnimation)

        print("jumped")
    }
    func duck() {
        var duck = [SKTexture]()
        
        
        for i in 0...15 {
            let name = "Dying\(i)"
            duck.append(SKTexture(imageNamed:name))
        }
        
        for i in (0...14).reverse() {
            let name = "Dying\(i)"
            duck.append(SKTexture(imageNamed:name))
        }
        
        
        
        
        
        
        let duckAnimation = SKAction.animateWithTextures(duck, timePerFrame: NSTimeInterval(0.017), resize: true, restore: true)
        self.runAction(duckAnimation)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 250, height: 50),center: CGPoint(x: 0, y: -120))
        
        
        let seconds = 0.5
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            
            self.initialize()
        }
        
    }
}