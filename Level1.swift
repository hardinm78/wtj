//
//  GameplayScene.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/22/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit


class Level1: SKScene, SKPhysicsContactDelegate {
    
    var player = Player()
    var obstacles = [SKSpriteNode]()
    
    var scoreLabel = SKLabelNode()
    var score = 0
    var pausePanel = SKSpriteNode()
    
    var canJump = false
    var movePlayer = false
    var playerOnObstacle = false
    var isAlive = false
    
    var spawner = NSTimer()
    var counter = NSTimer()
    
    override func didMoveToView(view: SKView) {
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(Level1.swipedUp(_:)))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(Level1.swipedDown(_:)))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        initialize()
    }
    
    override func update(currentTime: NSTimeInterval) {
        if isAlive{
            moveBackgroundsAndGrounds()
            
        }
        checkPlayersBounds()
        if movePlayer {
            player.position.x -= 3
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "Restart" {
                let level = Level1(fileNamed: "Level1")
                level!.scaleMode = .AspectFit
                self.view?.presentScene(level!, transition:SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
            }
            
            if nodeAtPoint(location).name == "Quit" {
                if highScore < score {
                    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "Highscore")
                }
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenu!.scaleMode = .AspectFit
                self.view?.presentScene(mainMenu!, transition:SKTransition.fadeWithColor(UIColor.orangeColor(), duration: NSTimeInterval(1.5)))
            }
            
            if nodeAtPoint(location).name == "Pause" {
                createPausePanel()
                
            }
            if nodeAtPoint(location).name == "Resume" {
                pausePanel.removeFromParent()
                self.scene?.paused = false
                
                spawner = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(2.5, secNum: 6)), target: self, selector: #selector(Level1.spawnObstacles), userInfo: nil, repeats: true)
                
                counter = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.3), target: self, selector: #selector(Level1.incrementScore),userInfo: nil, repeats: true)
                
            }
            
        }
        
        
    }
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Ground" {
            canJump = true
        }
        
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Obstacle" {
            if !canJump {
                movePlayer = true
                playerOnObstacle = true
            }
            
            
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Cactus" {
            playerDied()
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Obstacle" {
            movePlayer = false
            playerOnObstacle = false
            
        }
        
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        if canJump{
            canJump=false
            player.jump()
        }
        if playerOnObstacle {
            player.jump()
        }
        
        print("swiped up")
    }
    func swipedDown(sender:UISwipeGestureRecognizer){
        print("swiped down")
    }
    func initialize() {
        
        
        
        physicsWorld.contactDelegate = self
        isAlive = true
        createBG()
        createGrounds()
        createPlayer()
        createObstacles()
        getLabel()
        
        spawner = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(2.5, secNum: 6)), target: self, selector: #selector(Level1.spawnObstacles), userInfo: nil, repeats: true)
        
        counter = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.3), target: self, selector: #selector(Level1.incrementScore),userInfo: nil, repeats: true)
        
    }
    
    func createPlayer() {
        player = Player(imageNamed: "Running0")
        player.initialize()
        player.position = CGPoint(x: -10, y: 20)
        self.addChild(player)
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
            g.physicsBody = SKPhysicsBody(rectangleOfSize: g.size)
            g.physicsBody?.affectedByGravity = false
            g.physicsBody?.dynamic = false
            g.physicsBody?.categoryBitMask = ColliderType.Ground
            
            
            
            
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
    
    func createObstacles() {
        
        for i in 0...5 {
            let obstacle = SKSpriteNode(imageNamed: "Obstacle \(i)")
            
            if i == 0 {
                obstacle.name = "Cactus"
                obstacle.setScale(0.4)
            }else {
                obstacle.name = "Obstacle"
                obstacle.setScale(0.5)
            }
            
            
            
            
            obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            obstacle.zPosition = 1
            
            obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
            obstacle.physicsBody?.allowsRotation = false
            obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle
            
            obstacles.append(obstacle)
        }
        
    }
    
    func spawnObstacles() {
        let index = Int(arc4random_uniform(UInt32(obstacles.count)))
        
        let obstacle = obstacles[index].copy() as! SKSpriteNode
        
        obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: 50)
        
        self.addChild(obstacle)
        
        let move = SKAction.moveToX(-(self.frame.size.width * 2), duration: NSTimeInterval(15))
        
        let remove = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([move,remove])
        obstacle.runAction(sequence)
        
    }
    
    func randomBetweenNumbers(firstNum:CGFloat, secNum: CGFloat) -> CGFloat{
        
        let rNum = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secNum) + min(firstNum, secNum)
        print(rNum)
        return rNum
        
    }
    
    func checkPlayersBounds() {
        if isAlive{
            if player.position.x < -(self.frame.size.width/2) - 80{
                playerDied()
            }
        }
    }
    
    func getLabel() {
        scoreLabel = self.childNodeWithName("Score Label") as! SKLabelNode
        scoreLabel.text = "0M"
        
    }
    
    func incrementScore() {
        score += 1
        scoreLabel.text = "\(score)M"
    }
    
    func createPausePanel() {
        
        spawner.invalidate()
        counter.invalidate()
        
        self.scene?.paused = true
        
        pausePanel = SKSpriteNode(imageNamed: "Pause Panel")
        pausePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel.position = CGPoint(x: 0, y: 0)
        pausePanel.zPosition = 10
        
        let resume = SKSpriteNode(imageNamed: "Play")
        let quit = SKSpriteNode(imageNamed: "Quit")
        
        
        resume.name = "Resume"
        resume.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resume.position = CGPoint(x: -155, y: 0)
        resume.zPosition = 11
        resume.setScale(0.75)
        
        quit.name = "Quit"
        quit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quit.position = CGPoint(x: 155, y: 0)
        quit.zPosition = 11
        quit.setScale(0.75)

        pausePanel.addChild(resume)
        pausePanel.addChild(quit)
        
        self.addChild(pausePanel)
    }
    
    
    func playerDied() {
        
        
        
        if highScore < score {
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "Highscore")
        }
        
        
        player.removeFromParent()
        
        for child in children {
            if child.name == "Obstacle" || child.name == "Cactus" {
                child.removeFromParent()
            }
        }
        
        spawner.invalidate()
        counter.invalidate()
        
        isAlive = false
        
        let restart = SKSpriteNode(imageNamed: "Restart")
        let quit = SKSpriteNode(imageNamed: "Quit")
        
        restart.name = "Restart"
        restart.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        restart.position = CGPoint(x: -200, y: -100)
        restart.zPosition = 10
        restart.setScale(0)
        
        quit.name = "Quit"
        quit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quit.position = CGPoint(x: 200, y: -100)
        quit.zPosition = 10
        quit.setScale(0)
        
        let scaleUp = SKAction.scaleTo(1, duration: NSTimeInterval(0.5))
        restart.runAction(scaleUp)
        quit.runAction(scaleUp)
        
        self.addChild(restart)
        self.addChild(quit)
        
    }
    
    
}









