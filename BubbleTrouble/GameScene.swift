//
//  GameScene.swift
//  BubbleTrouble
//
//  Created by pat on 1/7/23.
//

import SpriteKit

class GameScene: SKScene {
    var bubbleTextures = [SKTexture]()
    var currentBubbleTexture = 0
    var maximumNumber = 1
    var bubbles = [SKSpriteNode]()
    
    var bubbleTimer: Timer?
    
    func createBubble() {
        let bubble = SKSpriteNode(texture: bubbleTextures[currentBubbleTexture])
        bubble.name = String(maximumNumber)
        bubble.zPosition = 1
        
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        label.text = bubble.name
        label.color = NSColor.white
        label.fontSize = 64
        label.verticalAlignmentMode = .center
        label.zPosition = 2
        
        bubble.addChild(label)
        addChild(bubble)
        bubbles.append(bubble)
        
        let xPos = Int.random(in: 0 ..< 800)
        let yPos = Int.random(in: 0 ..< 600)
        bubble.position = CGPoint(x: xPos, y: yPos)
        
        
        
        configurePhysics(for: bubble)
        nextBubble()
    }
    func nextBubble() {
        currentBubbleTexture += 1
        if currentBubbleTexture == bubbleTextures.count {
            currentBubbleTexture = 0
        }
        
        maximumNumber += Int.random(in: 1...3)
        let strMaximumNumber = String(maximumNumber)
        if strMaximumNumber.last! == "6" {
            maximumNumber += 1
        }
        if strMaximumNumber.last! == "9" {
            maximumNumber += 1
        }
    }
    func configurePhysics(for bubble: SKSpriteNode) {
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.size.width / 2)
        bubble.physicsBody?.linearDamping = 0
        bubble.physicsBody?.angularDamping = 0
        bubble.physicsBody?.restitution = 1
        bubble.physicsBody?.friction = 0
        
        let motionX = Double.random(in: -200...200)
        let motionY = Double.random(in: -200...200)
        bubble.physicsBody?.velocity = CGVector(dx: motionX, dy: motionY)
        bubble.physicsBody?.angularVelocity = Double.random(in: 0...1)
    }
    
    override func didMove(to view: SKView) {
        bubbleTextures.append(SKTexture(imageNamed: "bubbleBlue"))
        bubbleTextures.append(SKTexture(imageNamed: "bubbleCyan"))
        bubbleTextures.append(SKTexture(imageNamed: "bubbleGray"))
        bubbleTextures.append(SKTexture(imageNamed: "bubbleGreen"))
        bubbleTextures.append(SKTexture(imageNamed: "bubbleOrange"))
        bubbleTextures.append(SKTexture(imageNamed: "bubblePink"))
        bubbleTextures.append(SKTexture(imageNamed: "bubblePurple"))
        bubbleTextures.append(SKTexture(imageNamed: "bubbleRed"))
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector.zero
        for _ in 1...8 {
            createBubble()
        }
        bubbleTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            self?.createBubble()
        }
    }
}
