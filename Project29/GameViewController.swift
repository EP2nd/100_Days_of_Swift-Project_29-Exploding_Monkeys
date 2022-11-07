//
//  GameViewController.swift
//  Project29
//
//  Created by Edwin Przeźwiecki Jr. on 04/11/2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var currentGame: GameScene!

    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var playerNumber: UILabel!
    /// Challenge 1:
    @IBOutlet var scoreLabel: UILabel!
    /// Challenge 3:
    @IBOutlet var windStrengthLabel: UILabel!
    @IBOutlet var windDirectionPointer: UIImageView!
    @IBOutlet var windEmoji: UILabel!
    /// Challenge 3:
    var windStrength = 0.0 {
        didSet {
            switch windStrength {
            case -10.0 ... -7.6, 7.6 ... 10.0:
                windStrengthLabel.text = "\(abs(windStrength)) m/s'"
                windStrengthLabel.textColor = .systemRed
            case -7.5 ... -5.1, 5.1 ... 7.5:
                windStrengthLabel.text = "\(abs(windStrength)) m/s'"
                windStrengthLabel.textColor = .systemOrange
            case -5.0 ... -2.6, 2.6 ... 5.0:
                windStrengthLabel.text = "\(abs(windStrength)) m/s'"
                windStrengthLabel.textColor = .systemYellow
            case -2.5 ... 0.0, 0.1 ... 2.5:
                windStrengthLabel.text = "\(abs(windStrength)) m/s'"
                windStrengthLabel.textColor = .systemGreen
            default:
                windStrengthLabel.text = "0 m/s"
                windStrengthLabel.textColor = .white
            }
        }
    }
    /// Challenge 1:
    var playerOneScore = 0 {
        didSet {
            scoreLabel.text = "\(playerOneScore) : \(playerTwoScore)"
        }
    }
    var playerTwoScore = 0 {
        didSet {
            scoreLabel.text = "\(playerOneScore) : \(playerTwoScore)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        angleChanged(angleSlider)
        velocityChanged(velocitySlider)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
        
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func angleChanged(_ sender: Any) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        launchButton.isHidden = true
        
        currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }
        
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        
        velocitySlider.isHidden = false
        velocityLabel.isHidden = false
        
        launchButton.isHidden = false
    }
    
    /// Challenge 3:
    func drawWindDirectionPointer() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30))
        let img = renderer.image { ctx in
            switch windStrength {
            case -10.0 ... 0.1:
                ctx.cgContext.move(to: CGPoint(x: 30, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 0, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 5, y: 20))
                ctx.cgContext.move(to: CGPoint(x: 0, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 5, y: 10))
            case 0.0:
                return
            case 0.1 ... 10.0:
                ctx.cgContext.move(to: CGPoint(x: 0, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 30, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 25, y: 20))
                ctx.cgContext.move(to: CGPoint(x: 30, y: 15))
                ctx.cgContext.addLine(to: CGPoint(x: 25, y: 10))
            default:
                return
            }
            ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            ctx.cgContext.strokePath()
        }
        windDirectionPointer.image = img
    }
}
