//
//  CountyLine.swift
//  Welcome_To_Jackson
//
//  Created by Michael Hardin on 6/30/16.
//  Copyright © 2016 Michael Hardin. All rights reserved.
//

import SpriteKit
import GoogleMobileAds

class WoodrowWilson: SKScene, SKPhysicsContactDelegate {
    
    var BG = BGAndGround()
    var player = Player()
    var lowObstacles = [SKSpriteNode]()
    var highObstacles = [SKSpriteNode]()
    var scoreLabel = SKLabelNode()
    var livesLabel = SKLabelNode()
    var messageLabel = SKLabelNode()
    var score = 0.00
    var pausePanel = SKSpriteNode()
    var canJump = false
    var movePlayer = false
    var playerOnObstacle = false
    var isAlive = false
    var gamePaused = false
    var spawner = NSTimer()
    var spawner2 = NSTimer()
    //var counter = NSTimer()
    var lives = 0
    
    
    override func didMoveToView(view: SKView) {
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedUp(_:)))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedDown(_:)))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        player.runAction(SKAction.playSoundFileNamed("Jump.wav", waitForCompletion: false))
        initialize()
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        if isAlive{
            BG.moveBackgroundsAndGrounds(self)
        }
        checkPlayersBounds()
        if movePlayer {
            player.position.x -= 3
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        messageLabel.removeFromParent()
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if nodeAtPoint(location).name == "Restart" {
                let level = WoodrowWilson(fileNamed: "WoodrowWilson")
                level!.scaleMode = .AspectFit
                self.view?.presentScene(level!, transition:SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
            }
            
            if nodeAtPoint(location).name == "ContinueTry" {
                
                childNodeWithName("ContinueTry")?.removeFromParent()
                childNodeWithName("Quit")?.removeFromParent()
                
                isAlive = true
                
                BG.createBG(self)
                BG.createGrounds(self)
                createPlayer()
                
                spawner = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(2, secNum: 4)), target: self, selector: #selector(self.spawnLowObstacles), userInfo: nil, repeats: true)
                
                spawner2 = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(4, secNum: 8)), target: self, selector: #selector(self.spawnHighObstacles), userInfo: nil, repeats: true)
                
                
                //counter = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.3), target: self, selector: #selector(self.incrementScore),userInfo: nil, repeats: true)
            }
            
            
            
            if nodeAtPoint(location).name == "Quit" {
                
                
                
                
                spawner.invalidate()
                spawner2.invalidate()
                //counter.invalidate()
                
                
                
                if lives > 0 {
                    if interstitial.isReady {
                        let currentViewController:UIViewController=UIApplication.sharedApplication().keyWindow!.rootViewController!
                        
                        interstitial.presentFromRootViewController(currentViewController)
                    } else {
                        print("Ad wasn't ready")
                    }
                    
                    interstitial = GADInterstitial(adUnitID: "ca-app-pub-6381417154543225/8624542790")
                    let request = GADRequest()
                    interstitial.loadRequest(request)
                    
                }
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")
                mainMenu!.scaleMode = .AspectFit
                self.view?.presentScene(mainMenu!, transition:SKTransition.fadeWithColor(UIColor.orangeColor(), duration: NSTimeInterval(1.5)))
            }
            
            if nodeAtPoint(location).name == "Pause" {
                if isAlive{
                    if !gamePaused{
                        gamePaused = true
                        createPausePanel()
                    }
                }
            }
            if nodeAtPoint(location).name == "Resume" {
                
                gamePaused = false
                pausePanel.removeFromParent()
                self.scene?.paused = false
                
                spawner = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(1, secNum: 3)), target: self, selector: #selector(self.spawnLowObstacles), userInfo: nil, repeats: true)
                spawner2 = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(3, secNum: 5)), target: self, selector: #selector(self.spawnHighObstacles), userInfo: nil, repeats: true)
                
                //counter = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.3), target: self, selector: #selector(self.incrementScore),userInfo: nil, repeats: true)
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
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Bomb" {
            let explosion = SKEmitterNode(fileNamed: "explosion")
            self.runAction(SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false))
            
            explosion?.position = (secondBody.node?.position)!
            secondBody.node?.removeFromParent()
            explosion?.zPosition = 10
            self.addChild(explosion!)
            playerDied()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Pothole" {
            playerDied()
        }
        if firstBody.node?.name == "Player" && secondBody.node?.name == "coin" {
            secondBody.node?.removeFromParent()
            player.runAction(SKAction.playSoundFileNamed("Coin.wav", waitForCompletion: false))
            score += 1.50
            scoreLabel.text = "$\(score)"
            
            if score >= 70.00 {
                levelComplete()
            }
        }
        if firstBody.node?.name == "Player" && secondBody.node?.name == "cash" {
            secondBody.node?.removeFromParent()
            player.runAction(SKAction.playSoundFileNamed("Coin.wav", waitForCompletion: false))
            score += 5.00
            scoreLabel.text = "$\(score)"
            if score >= 70.00 {
                levelComplete()
            }
            
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
    
    func levelComplete() {
        if levelsCompleted < 10 {
            NSUserDefaults.standardUserDefaults().setInteger(10, forKey: "LevelsCompleted")
            levelsCompleted = 10
        }
        if currentLevel < 10 {
            NSUserDefaults.standardUserDefaults().setInteger(10, forKey: "CurrentLevel")
            currentLevel = 10
        }
        
        player.runAction(SKAction.playSoundFileNamed("woohoo.mp3", waitForCompletion: false))
        
        //self.scene?.paused = true
        let completeLabel = SKLabelNode(fontNamed: "Road Rage")
        completeLabel.text = "Level Complete"
        completeLabel.fontSize = 100
        completeLabel.fontColor = UIColor.redColor()
        completeLabel.zPosition = 10
        completeLabel.position = CGPoint(x: 0, y: 10)
        self.addChild(completeLabel)
        
        let seconds = 1.5
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            
            let level = OldCanton(fileNamed: "OldCanton")
            level!.scaleMode = .AspectFit
            self.view?.presentScene(level!, transition:SKTransition.fadeWithColor(UIColor.greenColor(), duration: NSTimeInterval(1.5)))
        }
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        if canJump{
            canJump=false
            player.runAction(SKAction.playSoundFileNamed("Jump.wav", waitForCompletion: false))
            player.jump()
        }
        if playerOnObstacle {
            player.runAction(SKAction.playSoundFileNamed("Jump.wav", waitForCompletion: false))
            player.jump()
        }
        
        //print("swiped up")
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        if canJump {
            player.duck()
        }
        //print("swiped down")
    }
    
    func initialize() {
        lives = 2
        physicsWorld.contactDelegate = self
        isAlive = true
        
        BG.createBG(self)
        BG.createGrounds(self)
        createPlayer()
        createLowObstacles()
        createHighObstacles()
        getLabel()
        
        spawner = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(1, secNum: 3)), target: self, selector: #selector(self.spawnLowObstacles), userInfo: nil, repeats: true)
        
        spawner2 = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(3, secNum: 5)), target: self, selector: #selector(self.spawnHighObstacles), userInfo: nil, repeats: true)
        
        
        //counter = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1.3), target: self, selector: #selector(self.incrementScore),userInfo: nil, repeats: true)
    }
    
    func createPlayer() {
        player = Player(imageNamed: "Running0")
        player.initialize()
        player.position = CGPoint(x: -240, y: 20)
        
        self.addChild(player)
    }
    func createLowObstacles() {
        
        
        let obstacle1 = SKSpriteNode(imageNamed:"Pothole")
        obstacle1.name = "Pothole"
        obstacle1.setScale(0.4)
        
        lowObstacles.append(obstacle1)
        
        let obstacle2 = SKSpriteNode(imageNamed:"Barrel")
        obstacle2.name = "Barrel"
        obstacle2.setScale(0.5)
        
        
        lowObstacles.append(obstacle2)
        
        
        
        let obstacle3 = SKSpriteNode(imageNamed:"cash")
        obstacle3.name = "cash"
        obstacle3.setScale(1)
        
        lowObstacles.append(obstacle3)
        
        let obstacle4 = SKSpriteNode(imageNamed:"coin")
        obstacle4.name = "coin"
        obstacle4.setScale(1)
        
        lowObstacles.append(obstacle4)
        
        let obstacle5 = SKSpriteNode(imageNamed:"Barrel")
        obstacle5.name = "Barrel"
        obstacle5.setScale(0.5)
        
        
        lowObstacles.append(obstacle5)
        
        
        let obstacle6 = SKSpriteNode(imageNamed:"Pothole")
        obstacle6.name = "Pothole"
        obstacle6.setScale(0.4)
        
        lowObstacles.append(obstacle6)
    }
    
    func createHighObstacles() {
        
        let obstacle1 = SKSpriteNode(imageNamed:"Bomb")
        obstacle1.name = "Bomb"
        obstacle1.setScale(0.4)
        
        highObstacles.append(obstacle1)
        
        
        let obstacle2 = SKSpriteNode(imageNamed:"coin")
        obstacle2.name = "coin"
        obstacle2.setScale(1)
        
        highObstacles.append(obstacle2)
        
        let obstacle3 = SKSpriteNode(imageNamed:"cash")
        obstacle3.name = "cash"
        obstacle3.setScale(1)
        
        highObstacles.append(obstacle3)
        
        let obstacle4 = SKSpriteNode(imageNamed:"Bomb")
        obstacle4.name = "Bomb"
        obstacle4.setScale(0.4)
        
        highObstacles.append(obstacle4)
        
    }
    func spawnLowObstacles() {
        let index = Int(arc4random_uniform(UInt32(lowObstacles.count)))
        print(index)
        let obstacle = lowObstacles[index].copy() as! SKSpriteNode
        obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        obstacle.zPosition = 4
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle
        obstacle.physicsBody?.collisionBitMask = ColliderType.Player | ColliderType.Ground
        //obstacle.physicsBody?.dynamic = false
        
        let move = SKAction.moveToX(-(self.frame.size.width * 2), duration: NSTimeInterval(7))
        
        if obstacle.name == "Pothole"{
            obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: obstacle.size.width - 100, height: obstacle.size.height - 20))
            obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -340)
            obstacle.physicsBody?.dynamic = false
        }else if obstacle.name == "Barrel"{
            obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -200)
            obstacle.physicsBody?.dynamic = false
        }else if obstacle.name == "coin"{
            obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -270)
            obstacle.physicsBody?.dynamic = false
        }else if obstacle.name == "cash"{
            obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: -270)
            obstacle.physicsBody?.dynamic = false
        }
        self.addChild(obstacle)
        
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move,remove])
        obstacle.runAction(sequence)
        
        spawner.invalidate()
        spawner = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(1, secNum: 3)), target: self, selector: #selector(self.spawnLowObstacles), userInfo: nil, repeats: true)
        
        
        
    }
    
    func spawnHighObstacles() {
        let index = Int(arc4random_uniform(UInt32(highObstacles.count)))
        print(index)
        let obstacle = highObstacles[index].copy() as! SKSpriteNode
        obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        obstacle.zPosition = 4
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.affectedByGravity = false
        //obstacle.physicsBody?.collisionBitMask = ColliderType.Player | ColliderType.Ground
        
        let move = SKAction.moveToX(-(self.frame.size.width * 2), duration: NSTimeInterval(4))
        
        if obstacle.name == "Bomb" {
            obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle
            obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: 20)
            obstacle.physicsBody?.affectedByGravity = false
        }else if obstacle.name == "coin" {
            obstacle.physicsBody?.categoryBitMask = ColliderType.Collectible
            obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: 150)
            obstacle.physicsBody?.affectedByGravity = false
        }else if obstacle.name == "cash" {
            obstacle.physicsBody?.categoryBitMask = ColliderType.Collectible
            obstacle.position = CGPoint(x: self.frame.width + obstacle.size.width, y: 150)
            obstacle.physicsBody?.affectedByGravity = false
        }
        
        self.addChild(obstacle)
        
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move,remove])
        obstacle.runAction(sequence)
        spawner2.invalidate()
        spawner2 = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(randomBetweenNumbers(3, secNum: 5)), target: self, selector: #selector(self.spawnHighObstacles), userInfo: nil, repeats: true)
    }
    
    func randomBetweenNumbers(firstNum:CGFloat, secNum: CGFloat) -> CGFloat{
        let rNum = CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secNum) + min(firstNum, secNum)
        print(rNum)
        return rNum
    }
    
    func checkPlayersBounds() {
        if isAlive{
            if player.position.x < -(self.frame.size.width/2) - 80{
                playerDiedOffScreen()
            }
        }
    }
    
    func getLabel() {
        scoreLabel = self.childNodeWithName("Score Label") as! SKLabelNode
        scoreLabel.text = "$0.0"
        messageLabel = self.childNodeWithName("Message") as! SKLabelNode
        messageLabel.text = "Collect $70 for Taxi"
        livesLabel = self.childNodeWithName("Lives Label") as! SKLabelNode
        if lives >= 0 {
            livesLabel.text = "\(lives)"
        }
    }
    
    func incrementScore() {
        //        score -= 1
        //        scoreLabel.text = "\(score)M"
    }
    func createPausePanel() {
        spawner.invalidate()
        spawner2.invalidate()
        //counter.invalidate()
        
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
        
        lives -= 1
        if lives >= 0 {
            livesLabel.text = "\(lives)"
        }
        let dead = SKSpriteNode(imageNamed: "Dead")
        dead.position = player.position
        dead.zPosition = 5
        dead.setScale(0.45)
        dead.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        dead.physicsBody!.mass = 0.5
        dead.physicsBody?.dynamic = true
        dead.physicsBody?.allowsRotation = true
        dead.runAction(SKAction.playSoundFileNamed("Death.mp3", waitForCompletion: false))
        dead.alpha = 0.5
        player.removeFromParent()
        
        scene?.addChild(dead)
        dead.physicsBody?.applyAngularImpulse(-0.1)
        
        
        
        
        let seconds = 1.0
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            
            for child in self.children {
                if child.name == "Pothole" || child.name == "Bomb" || child.name == "Barrel" || child.name == "coin" || child.name == "cash" {
                    child.removeFromParent()
                }
            }
            
            dead.physicsBody?.dynamic = false
            dead.removeFromParent()
            
            
            self.spawner.invalidate()
            self.spawner2.invalidate()
            //self.counter.invalidate()
            
            self.isAlive = false
            
            if self.lives < 0 {
                
                if interstitial.isReady {
                    let currentViewController:UIViewController=UIApplication.sharedApplication().keyWindow!.rootViewController!
                    
                    interstitial.presentFromRootViewController(currentViewController)
                } else {
                    print("Ad wasn't ready")
                }
                
                interstitial = GADInterstitial(adUnitID: "ca-app-pub-6381417154543225/8624542790")
                let request = GADRequest()
                interstitial.loadRequest(request)
                
                
                let restart = SKSpriteNode(imageNamed: "Restart")
                let quit = SKSpriteNode(imageNamed: "Quit")
                let gameOver = SKLabelNode(text: "Game Over")
                gameOver.fontName = "Road Rage"
                gameOver.fontSize = 100
                gameOver.fontColor = UIColor.redColor()
                gameOver.zPosition = 10
                gameOver.position = CGPoint(x: 0, y: 10)
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
                
                let scaleUp = SKAction.scaleTo(0.8, duration: NSTimeInterval(0.5))
                restart.runAction(scaleUp)
                quit.runAction(scaleUp)
                
                self.addChild(gameOver)
                self.addChild(restart)
                self.addChild(quit)
            }else {
                
                let continueTry = SKSpriteNode(imageNamed: "Play")
                let quit = SKSpriteNode(imageNamed: "Quit")
                
                continueTry.name = "ContinueTry"
                continueTry.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                continueTry.position = CGPoint(x: -200, y: -100)
                continueTry.zPosition = 10
                continueTry.setScale(0)
                
                quit.name = "Quit"
                quit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                quit.position = CGPoint(x: 200, y: -100)
                quit.zPosition = 10
                quit.setScale(0)
                
                let scaleUp = SKAction.scaleTo(1, duration: NSTimeInterval(0.5))
                continueTry.runAction(scaleUp)
                quit.runAction(scaleUp)
                
                self.addChild(continueTry)
                self.addChild(quit)
                
            }
        }
    }
    
    func playerDiedOffScreen() {
        lives -= 1
        if lives >= 0 {
            livesLabel.text = "\(lives)"
        }
        
        for child in self.children {
            if child.name == "Pothole" || child.name == "Bomb" || child.name == "Barrel" || child.name == "coin" || child.name == "cash" {
                child.removeFromParent()
            }
        }
        
        
        self.runAction(SKAction.playSoundFileNamed("Death.mp3", waitForCompletion: false))
        
        player.removeFromParent()
        self.spawner.invalidate()
        self.spawner2.invalidate()
        //self.counter.invalidate()
        
        self.isAlive = false
        
        if self.lives < 0 {
            
            if interstitial.isReady {
                let currentViewController:UIViewController=UIApplication.sharedApplication().keyWindow!.rootViewController!
                
                interstitial.presentFromRootViewController(currentViewController)
            } else {
                print("Ad wasn't ready")
            }
            
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-6381417154543225/8624542790")
            let request = GADRequest()
            interstitial.loadRequest(request)
            
            
            let restart = SKSpriteNode(imageNamed: "Restart")
            let quit = SKSpriteNode(imageNamed: "Quit")
            let gameOver = SKLabelNode(text: "Game Over")
            gameOver.fontName = "Road Rage"
            gameOver.fontSize = 100
            gameOver.fontColor = UIColor.redColor()
            gameOver.zPosition = 10
            gameOver.position = CGPoint(x: 0, y: 10)
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
            
            let scaleUp = SKAction.scaleTo(0.8, duration: NSTimeInterval(0.5))
            restart.runAction(scaleUp)
            quit.runAction(scaleUp)
            
            self.addChild(gameOver)
            self.addChild(restart)
            self.addChild(quit)
        }else {
            
            let continueTry = SKSpriteNode(imageNamed: "Play")
            let quit = SKSpriteNode(imageNamed: "Quit")
            
            continueTry.name = "ContinueTry"
            continueTry.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            continueTry.position = CGPoint(x: -200, y: -100)
            continueTry.zPosition = 10
            continueTry.setScale(0)
            
            quit.name = "Quit"
            quit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            quit.position = CGPoint(x: 200, y: -100)
            quit.zPosition = 10
            quit.setScale(0)
            
            let scaleUp = SKAction.scaleTo(1, duration: NSTimeInterval(0.5))
            continueTry.runAction(scaleUp)
            quit.runAction(scaleUp)
            
            self.addChild(continueTry)
            self.addChild(quit)
            
        }
    }
}


