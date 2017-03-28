//
//  GameScene.swift
//  pong
//
//  Created by Daniel Gormly on 21/2/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var scoreLabel1 = SKLabelNode()
    var scoreLabel2 = SKLabelNode()
    
    
    var score = [Int]()
    
    func startGame() {
        score = [0,0] // My score / enemy score
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position.x = 0
        ball.position.y = 0
        // Remove impulse.
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        scoreLabel1.text = "\(score[0])"
        scoreLabel2.text = "\(score[1])"
        print(score)
    }
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        scoreLabel1 = self.childNode(withName: "score1") as! SKLabelNode
        scoreLabel2 = self.childNode(withName: "score2") as! SKLabelNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        
        startGame()
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.4))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before every frame.
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
        
        if ball.position.y <= main.position.y - 70 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 70 {
            addScore(playerWhoWon: main)
        }
    }
}
