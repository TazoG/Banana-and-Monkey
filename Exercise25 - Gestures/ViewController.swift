//
//  ViewController.swift
//  Exercise25 - Gestures
//
//  Created by Tazo Gigitashvili on 28.02.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bananaView: UIImageView!
    @IBOutlet weak var monkeyView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        monkeyView.isUserInteractionEnabled = true
        monkeyView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        bananaView.isUserInteractionEnabled = true
        bananaView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if let monkeyView = sender.view {
            monkeyView.center = CGPoint(x: monkeyView.center.x + translation.x, y: monkeyView.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1.0, animations: {
            self.bananaView.center.y = self.view.bounds.height
        }) { (finished) in
            if self.monkeyView.frame.intersects(self.bananaView.frame) {
                self.showGameOverAlert()
            } else {
                self.resetGame()
            }
        }
    }
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Game Over", message: "You lost!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.resetGame()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func resetGame() {
        bananaView.center = CGPoint(x: 100, y: 100)
    }
}

